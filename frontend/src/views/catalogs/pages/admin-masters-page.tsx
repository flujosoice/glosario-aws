import { AddNameRow } from '../components/add-name-row';
import { useCatalogsController } from '../hooks/use-catalogs-controller';

/** Pestaña Maestros: Artículo y Cliente son base; un agregado se elimina solo si no tiene términos. */
export function AdminMastersPage() {
  const c = useCatalogsController();

  return (
    <div className="tags-col narrow">
      <p className="field-label">Maestros de Datos</p>
      <p className="form-hint" style={{ margin: '-4px 0 12px' }}>
        Son las matrices de atributos de donde salen el Campo en Base de Datos y el Campo en
        Softland. Asigna el maestro a cada término desde la pestaña Términos, con el botón Editar.
      </p>
      <AddNameRow
        id="maestro-new"
        placeholder="Nuevo maestro…"
        busy={c.busy}
        error={c.errors.maestros}
        onAdd={c.addMaster}
      />
      <div className="tag-list">
        {c.masters.map((m) => {
          const n = c.masterCounts[m.nombre] ?? 0;
          const canDelete = !m.esBase && !c.masterInUse.has(m.nombre);
          return (
            <div className="tag-list-item" key={m.id}>
              <span className="name">{m.nombre}</span>
              <span className="tag-count">
                {n} término{n === 1 ? '' : 's'}
                {m.esBase ? ' · base' : ''}
              </span>
              {!m.esBase && (
                <button
                  type="button"
                  className="tag-del-btn"
                  title={
                    canDelete
                      ? 'Eliminar maestro'
                      : 'No se puede eliminar: tiene términos asignados'
                  }
                  aria-label={`Eliminar maestro ${m.nombre}`}
                  disabled={!canDelete || c.busy}
                  onClick={() => c.removeMaster(m.id)}
                >
                  ×
                </button>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
