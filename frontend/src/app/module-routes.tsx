import type { RouteObject } from 'react-router-dom';
import { catalogsRoutes } from '../views/catalogs/routes/catalogs-routes';
import { dictionaryRoutes } from '../views/dictionary/routes/dictionary-routes';
import { adminTermsRoutes } from '../views/glossary/routes/admin-routes';
import { glossaryRoutes } from '../views/glossary/routes/glossary-routes';
import { AdminLayout } from './layout/admin-layout';

/** Título de la app (cabecera y <title>). */
export const appTitle = 'Glosario de Términos';

/** Enlace general = raíz; enlace de Procesos = /administracion#llave=<valor>. */
export const homePath = '/';

export const moduleRoutes: RouteObject[] = [
  ...glossaryRoutes,
  {
    path: 'administracion',
    element: <AdminLayout />,
    children: [...adminTermsRoutes, ...catalogsRoutes, ...dictionaryRoutes],
  },
];

/** Secciones de la barra superior (Administración solo se muestra con la llave de Procesos). */
export const navigation: { to: string; label: string }[] = [
  { to: '/', label: 'Glosario' },
  { to: '/administracion', label: 'Administración · Procesos' },
];
