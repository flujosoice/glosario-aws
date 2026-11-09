import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { catalogsApi, type Catalogs } from '../../catalogs/api/catalogs-api';
import { glossaryApi, type AdminTerm, type BdField } from '../api/glossary-api';
import { hasFields, sortTerms } from '../model/term-rules';

export type AdminFilter = 'all' | 'nuevo' | 'editado' | 'concampo' | 'sincampo' | 'eliminado';

export const ADMIN_FILTERS: [AdminFilter, string, (t: AdminTerm) => boolean][] = [
  ['all', 'Términos activos', (t) => !t.eliminado],
  ['nuevo', 'Nuevos', (t) => !t.eliminado && t.esNuevo],
  ['editado', 'Editados', (t) => !t.eliminado && t.editado],
  ['concampo', 'Con campo BD/Softland', (t) => !t.eliminado && hasFields(t)],
  ['sincampo', 'Sin campo BD/Softland', (t) => !t.eliminado && !hasFields(t)],
  ['eliminado', 'Eliminados', (t) => t.eliminado],
];

/** Borrador del formulario de términos: sobrevive al cambio de pestaña (p. ej. ir a Maestros y volver). */
export interface TermFormDraft {
  key: string;
  id: string | null;
  termino: string;
  definicion: string;
  etiquetas: string[];
  bdRows: BdField[];
  campoSoftland: string;
  maestros: string[];
}

/** Datos compartidos por las pestañas de Administración: términos (incluidos eliminados) y catálogos. */
export function useAdminDataController() {
  const [terms, setTerms] = useState<AdminTerm[]>([]);
  const [catalogs, setCatalogs] = useState<Catalogs>({ etiquetas: [], maestros: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<AdminFilter>('all');
  const [termForm, setTermForm] = useState<TermFormDraft | null>(null);
  const abortRef = useRef<AbortController | null>(null);

  const load = useCallback(async () => {
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;
    setLoading(true);
    setError(null);
    try {
      const [list, cats] = await Promise.all([
        glossaryApi.listAdmin({ signal: controller.signal }),
        catalogsApi.get({ signal: controller.signal }),
      ]);
      setTerms(sortTerms(list));
      setCatalogs(cats);
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

  const upsertTerm = useCallback((term: AdminTerm) => {
    setTerms((list) => sortTerms([...list.filter((t) => t.id !== term.id), term]));
  }, []);

  /** La API quita la etiqueta eliminada de los términos; aquí se refleja sin recargar. */
  const dropTag = useCallback((name: string) => {
    setTerms((list) =>
      list.map((t) => ({ ...t, etiquetas: t.etiquetas.filter((e) => e !== name) })),
    );
  }, []);

  const stats = useMemo(
    () => ADMIN_FILTERS.map(([key, label, fn]) => ({ key, label, count: terms.filter(fn).length })),
    [terms],
  );

  return {
    terms,
    catalogs,
    setCatalogs,
    loading,
    error,
    reload: load,
    upsertTerm,
    dropTag,
    filter,
    setFilter,
    stats,
    termForm,
    setTermForm,
  };
}

export type AdminData = ReturnType<typeof useAdminDataController>;
