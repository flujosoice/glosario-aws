import { useCallback, useEffect, useRef, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { getAccessKey } from '../../../shared/access/access-key';
import { accessApi } from '../api/access-api';

export interface AccessState {
  loading: boolean;
  canAdmin: boolean;
  label: string | null;
  error: string | null;
  reload: () => void;
}

/** Sin llave en el enlace no se consulta la API: es el enlace general (solo lectura). */
export function useAccessController(): AccessState {
  const hasKey = getAccessKey() !== null;
  const [loading, setLoading] = useState(hasKey);
  const [canAdmin, setCanAdmin] = useState(false);
  const [label, setLabel] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const abortRef = useRef<AbortController | null>(null);

  const load = useCallback(async () => {
    if (!hasKey) return;
    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;
    setLoading(true);
    setError(null);
    try {
      const access = await accessApi.get({ signal: controller.signal });
      setCanAdmin(access.puedeAdministrar);
      setLabel(access.etiqueta);
    } catch (e) {
      const apiError = normalizeError(e);
      if (!apiError.isCanceled) setError(apiError.message);
    } finally {
      if (!controller.signal.aborted) setLoading(false);
    }
  }, [hasKey]);

  useEffect(() => {
    load();
    return () => abortRef.current?.abort();
  }, [load]);

  return { loading, canAdmin, label, error, reload: load };
}
