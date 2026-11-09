import { createContext, useContext, type ReactNode } from 'react';
import { useAccessController, type AccessState } from '../hooks/use-access-controller';

const AccessContext = createContext<AccessState | null>(null);

export function AccessProvider({ children }: { children: ReactNode }) {
  const access = useAccessController();
  return <AccessContext.Provider value={access}>{children}</AccessContext.Provider>;
}

export function useAccess(): AccessState {
  const access = useContext(AccessContext);
  if (!access) throw new Error('useAccess debe usarse dentro de <AccessProvider>.');
  return access;
}
