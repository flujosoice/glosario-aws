import { createBrowserRouter, Navigate } from 'react-router-dom';
import { AccessProvider } from '../views/access/components/access-provider';
import { AppLayout } from './layout/app-layout';
import { homePath, moduleRoutes } from './module-routes';

/** Sin login: el Portal Interno Mayoreo controla quién abre cada enlace. */
export const router = createBrowserRouter([
  {
    path: '/',
    element: (
      <AccessProvider>
        <AppLayout />
      </AccessProvider>
    ),
    children: moduleRoutes,
  },
  { path: '*', element: <Navigate to={homePath} replace /> },
]);
