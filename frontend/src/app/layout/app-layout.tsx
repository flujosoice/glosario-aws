import { useState } from 'react';
import { NavLink, Outlet, useLocation } from 'react-router-dom';
import { useTheme } from '../../shared/theme/use-theme';
import {
  BookIcon,
  LockIcon,
  MoonIcon,
  SidebarIcon,
  SunIcon,
  UserIcon,
} from '../../shared/ui/icons';
import { useAccess } from '../../views/access/components/access-provider';

const TODAY = new Date().toLocaleDateString('es-VE', {
  day: 'numeric',
  month: 'long',
  year: 'numeric',
});

/** Barra superior del glosario. "Administración · Procesos" solo aparece con la llave de Procesos. */
export function AppLayout() {
  const { canAdmin } = useAccess();
  const { isDark, toggle } = useTheme();
  const [sidebarOpen, setSidebarOpen] = useState(true);
  const onGlossary = !useLocation().pathname.startsWith('/administracion');

  return (
    <>
      <div className="topbar">
        <div className="topbar-left">
          {onGlossary && (
            <button
              type="button"
              className="icon-btn"
              title="Mostrar/ocultar filtros"
              aria-label="Mostrar u ocultar filtros"
              onClick={() => setSidebarOpen((v) => !v)}
            >
              <SidebarIcon />
            </button>
          )}
          {canAdmin && (
            <nav className="view-nav" aria-label="Secciones">
              <NavLink to="/" end className={({ isActive }) => (isActive ? 'active' : '')}>
                <BookIcon />
                Glosario
              </NavLink>
              <NavLink
                to="/administracion"
                className={({ isActive }) => (isActive ? 'active' : '')}
              >
                <LockIcon />
                <span>
                  Administración<span className="lbl-long"> · Procesos</span>
                </span>
              </NavLink>
            </nav>
          )}
        </div>
        <div className="topbar-right">
          <button
            type="button"
            className="icon-btn"
            title="Cambiar tema"
            aria-label="Cambiar tema claro u oscuro"
            onClick={toggle}
          >
            {isDark ? <MoonIcon /> : <SunIcon />}
          </button>
          <span className="today">
            Hoy es <b>{TODAY}</b>
          </span>
          <div className="avatar" title="Glosario de Términos de Mayoreo">
            <UserIcon />
          </div>
        </div>
      </div>
      <Outlet context={{ sidebarOpen }} />
    </>
  );
}
