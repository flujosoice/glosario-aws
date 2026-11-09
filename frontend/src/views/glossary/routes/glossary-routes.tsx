import type { RouteObject } from 'react-router-dom';
import { GlossaryPage } from '../pages/glossary-page';

/** Enlace general (solo lectura): la raíz de la app. */
export const glossaryRoutes: RouteObject[] = [{ index: true, element: <GlossaryPage /> }];
