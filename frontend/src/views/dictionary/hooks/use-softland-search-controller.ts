import { useCallback, useEffect, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { dictionaryApi, type MatchOption } from '../api/dictionary-api';

/** Búsqueda de columnas en el Diccionario de Softland sincronizado (tabla en Aurora, no Excel). */
export function useSoftlandSearchController() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<MatchOption[] | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const abortRef = useRef<AbortController | null>(null);

  useEffect(() => () => abortRef.current?.abort(), []);

  const search = useCallback(async () => {
    const q = query.trim();
    if (q.length < 2) {
      setError('Escribe al menos 2 caracteres para buscar.');
      return;
    }
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;
    setLoading(true);
    setError(null);
    try {
      setResults(await dictionaryApi.search(q, { signal: controller.signal }));
    } catch (e) {
      const apiError = normalizeError(e);
      if (!apiError.isCanceled) setError(apiError.message);
    } finally {
      if (!controller.signal.aborted) setLoading(false);
    }
  }, [query]);

  const reset = () => {
    abortRef.current?.abort();
    setQuery('');
    setResults(null);
    setError(null);
  };

  return { query, setQuery, results, loading, error, search, reset };
}
