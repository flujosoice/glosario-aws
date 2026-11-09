import { createContext, useContext, type ReactNode } from 'react';
import { useAdminDataController, type AdminData } from '../hooks/use-admin-data-controller';

const AdminDataContext = createContext<AdminData | null>(null);

export function AdminDataProvider({ children }: { children: ReactNode }) {
  const data = useAdminDataController();
  return <AdminDataContext.Provider value={data}>{children}</AdminDataContext.Provider>;
}

export function useAdminData(): AdminData {
  const data = useContext(AdminDataContext);
  if (!data) throw new Error('useAdminData debe usarse dentro de <AdminDataProvider>.');
  return data;
}
