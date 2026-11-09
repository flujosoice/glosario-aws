import type { RouteObject } from 'react-router-dom';
import { AdminMastersPage } from '../pages/admin-masters-page';
import { AdminTagsPage } from '../pages/admin-tags-page';

/** Pestañas Etiquetas y Maestros (hijas de /administracion). */
export const catalogsRoutes: RouteObject[] = [
  { path: 'etiquetas', element: <AdminTagsPage /> },
  { path: 'maestros', element: <AdminMastersPage /> },
];
