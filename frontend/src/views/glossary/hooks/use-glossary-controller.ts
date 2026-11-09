import { useCallback, useDeferredValue, useEffect, useMemo, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { catalogsApi, type Catalogs } from '../../catalogs/api/catalogs-api';
import { glossaryApi, type BdField, type Term } from '../api/glossary-api';
import {
  matchesFilters,
  masterNames,
  sortTerms,
  tagCounts,
  tagNames,
  toInput,
  type FieldsFilter,
  type TermFilters,
  type ViewMode,
} from '../model/term-rules';

const EMPTY_FILTERS: TermFilters = {
  query: '',
  origen: new Set(),
  sim: new Set(),
  maestro: '',
  fields: '',
};

export function useGlossaryController() {
  const [terms, setTerms] = useState<Term[]>([]);
  const [catalogs, setCatalogs] = useState<Catalogs>({ etiquetas: [], maestros: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filters, setFilters] = useState<TermFilters>(EMPTY_FILTERS);
  const [view, setView] = useState<ViewMode>('grid');
  const [selectedId, setSelectedId] = useState<string | null>(null);
  const [saveError, setSaveError] = useState<string | null>(null);
  const abortRef = useRef<AbortController | null>(null);

  const load = useCallback(async () => {
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;
    setLoading(true);
    setError(null);
    try {
      const [list, cats] = await Promise.all([
        glossaryApi.list({ signal: controller.signal }),
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

  const deferredFilters = useDeferredValue(filters);
  const visibleIds = useMemo(
    () => new Set(terms.filter((t) => matchesFilters(t, deferredFilters)).map((t) => t.id)),
    [terms, deferredFilters],
  );
  const counts = useMemo(() => tagCounts(terms), [terms]);
  const origenTags = useMemo(() => tagNames(catalogs.etiquetas, 'silo_sistema'), [catalogs]);
  const simTags = useMemo(() => tagNames(catalogs.etiquetas, 'rol_reporte_sim'), [catalogs]);
  const masters = useMemo(() => masterNames(catalogs.maestros), [catalogs]);
  const selected = terms.find((t) => t.id === selectedId) ?? null;

  const setQuery = (query: string) => setFilters((f) => ({ ...f, query }));
  const toggleTag = (kind: 'origen' | 'sim', tag: string) =>
    setFilters((f) => {
      const next = new Set(f[kind]);
      if (next.has(tag)) next.delete(tag);
      else next.add(tag);
      return { ...f, [kind]: next };
    });
  const setMaestro = (maestro: string) => setFilters((f) => ({ ...f, maestro }));
  const setFields = (fields: FieldsFilter) => setFilters((f) => ({ ...f, fields }));
  const clearFilters = () => setFilters(EMPTY_FILTERS);

  /** Procesos corrige Campo BD / Softland desde la ficha (no marca el término como Editado). */
  const saveFields = useCallback(async (term: Term, camposBd: BdField[], campoSoftland: string) => {
    setSaveError(null);
    try {
      const updated = await glossaryApi.update(term.id, {
        ...toInput(term),
        camposBd,
        campoSoftland,
      });
      setTerms((list) => list.map((t) => (t.id === updated.id ? updated : t)));
    } catch (e) {
      setSaveError(normalizeError(e).message);
    }
  }, []);

  return {
    terms,
    loading,
    error,
    reload: load,
    filters,
    setQuery,
    toggleTag,
    setMaestro,
    setFields,
    clearFilters,
    visibleIds,
    counts,
    origenTags,
    simTags,
    masters,
    view,
    setView,
    selected,
    openTerm: setSelectedId,
    closeTerm: () => setSelectedId(null),
    saveFields,
    saveError,
  };
}
