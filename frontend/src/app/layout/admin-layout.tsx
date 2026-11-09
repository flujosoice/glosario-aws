import { RequireAdmin } from '../../views/access/components/require-admin';
import { AdminDataProvider } from '../../views/glossary/components/admin-data-provider';
import { AdminShell } from '../../views/glossary/components/admin-shell';

/** /administracion y sus pestañas: solo con la llave de Procesos; los datos se cargan una vez. */
export function AdminLayout() {
  return (
    <RequireAdmin>
      <AdminDataProvider>
        <AdminShell />
      </AdminDataProvider>
    </RequireAdmin>
  );
}
