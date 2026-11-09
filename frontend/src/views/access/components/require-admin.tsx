import type { ReactNode } from 'react';
import { Navigate } from 'react-router-dom';
import { ErrorState, LoadingState } from '../../../shared/ui/state-views';
import { useAccess } from './access-provider';

/** La interfaz se oculta sin llave válida; la API rechaza igual cualquier escritura sin ella. */
export function RequireAdmin({ children }: { children: ReactNode }) {
  const { loading, canAdmin, error, reload } = useAccess();
  if (loading) return <LoadingState message="Verificando el acceso de Procesos…" />;
  if (error) return <ErrorState message={error} onRetry={reload} />;
  if (!canAdmin) return <Navigate to="/" replace />;
  return <>{children}</>;
}
