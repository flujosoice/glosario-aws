import { useEffect, useMemo, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { useAdminData } from '../components/admin-data-provider';
import { glossaryApi, type AdminTerm, type TermInput } from '../api/glossary-api';
import { masterNames, searchText, tagNames } from '../model/term-rules';
import { ADMIN_FILTERS, type TermFormDraft } from './use-admin-data-controller';

const PAGE = 150;
const CONFIRM_MS = 3000;

function emptyForm(): TermFormDraft {
  return {
    key: `f${Date.now()}`,
    id: null,
    termino: '',
    definicion: '',
    etiquetas: [],
    bdRows: [{ campo: '', aplicaA: '' }],
    campoSoftland: '',
    maestros: [],
  };
}

function formFrom(term: AdminTerm): TermFormDraft {
  return {
    key: `f${Date.now()}`,
    id: term.id,
    termino: term.termino,
    definicion: term.definicion,
    etiquetas: [...term.etiquetas],
    bdRows: term.camposBd.length
      ? term.camposBd.map((f) => ({ ...f }))
      : [{ campo: '', aplicaA: '' }],
    campoSoftland: term.campoSoftland,
    maestros: [...term.maestros],
  };
}

/** Validación del formulario (la API vuelve a validar): término obligatorio y "Aplica a" si hay varios campos. */
export function validateForm(form: TermFormDraft): { input?: TermInput; error?: string } {
  const termino = form.termino.trim();
  if (!termino) return { error: 'El término no puede estar vacío.' };
  const rows = form.bdRows
    .map((r) => ({ campo: r.campo.trim(), aplicaA: r.aplicaA.trim() }))
    .filter((r) => r.campo);
  if (rows.length > 1 && rows.some((r) => !r.aplicaA))
    return { error: 'Indica a qué empresa o tabla aplica cada Campo en Base de Datos.' };
  return {
    input: {
      termino,
      definicion: form.definicion.trim(),
      etiquetas: form.etiquetas,
      camposBd: rows,
      campoSoftland: form.campoSoftland.trim(),
      maestros: form.maestros,
    },
  };
}

export function useAdminTermsController() {
  const data = useAdminData();
  const { terms, filter, termForm, setTermForm, upsertTerm, catalogs } = data;
  const [query, setQuery] = useState('');
  const [limit, setLimit] = useState(PAGE);
  const [formError, setFormError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [actionError, setActionError] = useState<string | null>(null);
  const [confirming, setConfirming] = useState<Set<string>>(new Set());
  const timers = useRef<Record<string, number>>({});
  // Las acciones se cancelan si se sale de la pestaña antes de que responda la API.
  const abortRef = useRef<AbortController>(new AbortController());

  useEffect(() => setLimit(PAGE), [query, filter]);
  useEffect(() => {
    const controller = new AbortController();
    abortRef.current = controller;
    const pending = timers.current;
    return () => {
      controller.abort();
      Object.values(pending).forEach((t) => window.clearTimeout(t));
    };
  }, []);
  const signal = () => ({ signal: abortRef.current.signal });

  const rows = useMemo(() => {
    const fn = ADMIN_FILTERS.find((f) => f[0] === filter)?.[2] ?? ADMIN_FILTERS[0][2];
    const q = query.trim().toLowerCase();
    return terms.filter(fn).filter((t) => !q || searchText(t).includes(q));
  }, [terms, filter, query]);

  const run = async (action: () => Promise<AdminTerm>) => {
    setActionError(null);
    try {
      upsertTerm(await action());
    } catch (e) {
      const apiError = normalizeError(e);
      if (!apiError.isCanceled) setActionError(apiError.message);
    }
  };

  const save = async () => {
    if (!termForm) return;
    const { input, error } = validateForm(termForm);
    if (!input) return setFormError(error ?? null);
    setSaving(true);
    setFormError(null);
    try {
      const saved = termForm.id
        ? await glossaryApi.update(termForm.id, input, signal())
        : await glossaryApi.create(input, signal());
      upsertTerm(saved);
      setTermForm(null);
    } catch (e) {
      const apiError = normalizeError(e);
      if (!apiError.isCanceled) setFormError(apiError.message);
    } finally {
      setSaving(false);
    }
  };

  /** Eliminar pide un segundo clic dentro de 3 segundos. */
  const requestDelete = (id: string) => {
    if (confirming.has(id)) {
      window.clearTimeout(timers.current[id]);
      setConfirming((s) => new Set([...s].filter((x) => x !== id)));
      return run(() => glossaryApi.remove(id, signal()));
    }
    setConfirming((s) => new Set(s).add(id));
    timers.current[id] = window.setTimeout(
      () => setConfirming((s) => new Set([...s].filter((x) => x !== id))),
      CONFIRM_MS,
    );
  };

  return {
    query,
    setQuery,
    rows,
    shownRows: rows.slice(0, limit),
    limit,
    showMore: () => setLimit((l) => l + PAGE),
    showAll: () => setLimit(rows.length),
    form: termForm,
    setForm: setTermForm,
    openNew: () => {
      setFormError(null);
      setTermForm(emptyForm());
    },
    openEdit: (term: AdminTerm) => {
      setFormError(null);
      setTermForm(formFrom(term));
    },
    cancel: () => setTermForm(null),
    save,
    saving,
    formError,
    actionError,
    confirming,
    requestDelete,
    restore: (id: string) => run(() => glossaryApi.restore(id, signal())),
    origenTags: tagNames(catalogs.etiquetas, 'silo_sistema'),
    simTags: tagNames(catalogs.etiquetas, 'rol_reporte_sim'),
    masters: masterNames(catalogs.maestros),
  };
}
