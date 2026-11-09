import { NavLink, Outlet, useNavigate } from 'react-router-dom';
import { LockIcon } from '../../../shared/ui/icons';
import { ErrorState, LoadingState } from '../../../shared/ui/state-views';
import { useAdminData } from './admin-data-provider';

const TABS = [
  { to: '/administracion', label: 'Términos', end: true },
  { to: '/administracion/etiquetas', label: 'Etiquetas', end: false },
  { to: '/administracion/maestros', label: 'Maestros', end: false },
  { to: '/administracion/diccionario', label: 'Diccionario Softland', end: false },
];

/** Encabezado, indicadores y pestañas de Administración · Procesos. */
export function AdminShell() {
  const { stats, filter, setFilter, loading, error, reload } = useAdminData();
  const navigate = useNavigate();

  return (
    <div className="shell">
      <div className="page-head">
        <div>
          <h1>Administración del glosario</h1>
          <p className="page-sub">
            Crear, editar y eliminar términos, completar sus campos de Base de Datos y Softland, y
            gestionar las etiquetas y los maestros.
          </p>
        </div>
        <span className="access-badge">
          <LockIcon size={12} />
          Solo equipo de Procesos
        </span>
      </div>

      <div className="admin-stats">
        {stats.map((s) => (
          <button
            type="button"
            key={s.key}
            className={`admin-stat${filter === s.key ? ' active' : ''}`}
            onClick={() => {
              setFilter(s.key);
              navigate('/administracion');
            }}
          >
            <span className="n">{s.count}</span>
            <span className="l">{s.label}</span>
          </button>
        ))}
      </div>

      <div className="admin-card">
        <nav className="admin-tabs" aria-label="Pestañas de Administración">
          {TABS.map((t) => (
            <NavLink
              key={t.to}
              to={t.to}
              end={t.end}
              className={({ isActive }) => `admin-tab${isActive ? ' active' : ''}`}
            >
              {t.label}
            </NavLink>
          ))}
        </nav>
        <div className="admin-body">
          {loading && <LoadingState message="Cargando la administración…" />}
          {error && <ErrorState message={error} onRetry={reload} />}
          {!loading && !error && <Outlet />}
        </div>
      </div>
    </div>
  );
}
