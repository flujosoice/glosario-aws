import type { RouteObject } from 'react-router-dom';
import { AdminDictionaryPage } from '../pages/admin-dictionary-page';

/** Pestaña Diccionario Softland (hija de /administracion). */
export const dictionaryRoutes: RouteObject[] = [
  { path: 'diccionario', element: <AdminDictionaryPage /> },
];
