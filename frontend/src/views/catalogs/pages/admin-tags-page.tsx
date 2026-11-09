import { TagPill } from '../../../shared/ui/tag-pill';
import { AddNameRow } from '../components/add-name-row';
import { useCatalogsController, type Tag, type TagType } from '../hooks/use-catalogs-controller';

const COLUMNS: { tipo: TagType; title: string }[] = [
  { tipo: 'silo_sistema', title: 'Silo / Sistema de Origen' },
  { tipo: 'rol_reporte_sim', title: 'Rol en Reporte SIM' },
];

/** Pestaña Etiquetas: agregar, ver cuántos términos tiene cada una y eliminar solo las que no son base. */
export function AdminTagsPage() {
  const c = useCatalogsController();
  const byType = (tipo: TagType): Tag[] =>
    c.tags.filter((t) => t.tipo === tipo).sort((a, b) => a.nombre.localeCompare(b.nombre, 'es'));

  return (
    <div className="tags-columns">
      {COLUMNS.map(({ tipo, title }) => (
        <div className="tags-col" key={tipo}>
          <p className="field-label">{title}</p>
          <AddNameRow
            id={`tag-new-${tipo}`}
            placeholder="Nueva etiqueta…"
            busy={c.busy}
            error={c.errors[tipo]}
            onAdd={(name) => c.addTag(tipo, name)}
          />
          <div className="tag-list">
            {byType(tipo).map((tag) => {
              const n = c.tagCounts[tag.nombre] ?? 0;
              return (
                <div className="tag-list-item" key={tag.id}>
                  <TagPill name={tag.nombre} />
                  <span className="tag-count">
                    {n} término{n === 1 ? '' : 's'}
                  </span>
                  {!tag.esBase && (
                    <button
                      type="button"
                      className="tag-del-btn"
                      title="Eliminar etiqueta"
                      aria-label={`Eliminar etiqueta ${tag.nombre}`}
                      disabled={c.busy}
                      onClick={() => c.removeTag(tag.id, tipo)}
                    >
                      ×
                    </button>
                  )}
                </div>
              );
            })}
            {byType(tipo).length === 0 && <p className="muted-note">Sin etiquetas.</p>}
          </div>
        </div>
      ))}
    </div>
  );
}
