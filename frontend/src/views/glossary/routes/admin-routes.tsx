import type { RouteObject } from 'react-router-dom';
import { AdminTermsPage } from '../pages/admin-terms-page';

/** Pestaña inicial de /administracion (las demás pestañas las aportan catalogs y dictionary). */
export const adminTermsRoutes: RouteObject[] = [{ index: true, element: <AdminTermsPage /> }];
