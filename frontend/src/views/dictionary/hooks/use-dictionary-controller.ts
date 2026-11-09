import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { catalogsApi } from '../../catalogs/api/catalogs-api';
import { useAdminData } from '../../glossary/components/admin-data-provider';
import {
  dictionaryApi,
  type Confidence,
  type DictionaryMatch,
  type MatchOption,
  type MatchStatus,
} from '../api/dictionary-api';

export type { Confidence, MatchStatus } from '../api/dictionary-api';

export const NEW_MASTER = '__nuevo__';

export interface MatchDraft {
  opt: number;
  extra: MatchOption[];
  bd: string;
  sl: string;
  mae: string;
  maeNuevo: string;
}

function initialDraft(m: DictionaryMatch): MatchDraft {
  const o = m.opciones[0];
  return {
    opt: 0,
    extra: [],
    bd: o?.columna ?? '',
    sl: o?.etiqueta ?? '',
    mae: m.maestroSugerido,
    maeNuevo: '',
  };
}

export function useDictionaryController() {
  const admin = useAdminData();
  const [matches, setMatches] = useState<DictionaryMatch[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [status, setStatus] = useState<MatchStatus | ''>('pendiente');
  const [conf, setConf] = useState<Confidence | ''>('');
  const [pos, setPos] = useState(0);
  const [drafts, setDrafts] = useState<Record<string, MatchDraft>>({});
  const [actionError, setActionError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const abortRef = useRef<AbortController | null>(null);

  const load = useCallback(async () => {
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;
    setLoading(true);
    setError(null);
    try {
      setMatches(await dictionaryApi.list({ signal: controller.signal }));
    } catch (e) {
      const apiError = normalizeError(e);
      if (!apiError.isCanceled) setError(apiError.message);
    } finally {
      if (!controller.signal.aborted) setLoading(false);
    }
  }, []);

  useEffect(() => {
    load();
    return () => abortRef.current?.abort();
  }, [load]);

  const counts = useMemo(() => {
    const c: Record<string, number> = {
      pendiente: 0,
      aplicada: 0,
      descartada: 0,
      '': matches.length,
    };
    for (const m of matches) c[m.estado] += 1;
    return c;
  }, [matches]);
  const list = useMemo(
    () =>
      matches
        .filter((m) => !status || m.estado === status)
        .filter((m) => !conf || m.confianza === conf)
        .sort((a, b) => a.orden - b.orden),
    [matches, status, conf],
  );
  const index = Math.min(pos, Math.max(list.length - 1, 0));
  const current = list[index] ?? null;
  const draft = current ? (drafts[current.id] ?? initialDraft(current)) : null;
  const term = current ? (admin.terms.find((t) => t.id === current.terminoId) ?? null) : null;

  const setDraft = (patch: Partial<MatchDraft>) =>
    current &&
    setDrafts((d) => ({
      ...d,
      [current.id]: { ...(d[current.id] ?? initialDraft(current)), ...patch },
    }));
  const options = current && draft ? [...current.opciones, ...draft.extra] : [];
  const pickOption = (i: number) =>
    setDraft({ opt: i, bd: options[i].columna, sl: options[i].etiqueta });
  const addOption = (o: MatchOption) =>
    draft &&
    setDraft({ extra: [...draft.extra, o], opt: options.length, bd: o.columna, sl: o.etiqueta });

  const replace = (m: DictionaryMatch) =>
    setMatches((list) => list.map((x) => (x.id === m.id ? m : x)));
  const move = (delta: number) =>
    setPos(Math.min(Math.max(index + delta, 0), Math.max(list.length - 1, 0)));
  const act = async (fn: () => Promise<void>) => {
    setActionError(null);
    setBusy(true);
    try {
      await fn();
      if (!status) move(1);
    } catch (e) {
      setActionError(normalizeError(e).message);
    } finally {
      setBusy(false);
    }
  };

  const apply = () => {
    if (!current || !draft) return;
    const bd = draft.bd.trim();
    const maestro = (draft.mae === NEW_MASTER ? draft.maeNuevo : draft.mae).trim();
    if (!bd) return setActionError('Indica el Campo en Base de Datos.');
    if (draft.mae === NEW_MASTER && !maestro)
      return setActionError('Escribe el nombre del nuevo maestro.');
    const tabla = options[draft.opt]?.tabla ?? '';
    return act(async () => {
      const result = await dictionaryApi.apply(current.id, {
        columna: bd,
        tabla,
        etiqueta: draft.sl.trim(),
        maestro,
      });
      replace(result.coincidencia);
      admin.upsertTerm(result.termino);
      if (
        maestro &&
        !admin.catalogs.maestros.some((m) => m.nombre.toLowerCase() === maestro.toLowerCase())
      )
        admin.setCatalogs(await catalogsApi.get());
    });
  };

  return {
    loading,
    error,
    reload: load,
    counts,
    status,
    setStatus: (s: MatchStatus | '') => (setStatus(s), setPos(0)),
    conf,
    setConf: (c: Confidence | '') => (setConf(c), setPos(0)),
    list,
    index,
    current,
    term,
    draft,
    options,
    masters: admin.catalogs.maestros.map((m) => m.nombre),
    setDraft,
    pickOption,
    addOption,
    prev: () => move(-1),
    next: () => move(1),
    apply,
    discard: () => current && act(async () => replace(await dictionaryApi.discard(current.id))),
    reopen: () => current && act(async () => replace(await dictionaryApi.reopen(current.id))),
    busy,
    actionError,
  };
}
