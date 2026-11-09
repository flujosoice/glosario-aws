import { TagPills } from '../../../shared/ui/tag-pill';
import type { AdminTerm } from '../api/glossary-api';
import { BADGE_LABEL, formatBdFields } from '../model/term-rules';

interface AdminTermRowProps {
  term: AdminTerm;
  confirming: boolean;
  onEdit: (term: AdminTerm) => void;
  onDelete: (id: string) => void;
  onRestore: (id: string) => void;
}

function StatusLabel({ term }: { term: AdminTerm }) {
  if (term.eliminado) return <span className="pill status eliminado">Eliminado</span>;
  if (term.esNuevo) return <span className="pill status nuevo">Nuevo</span>;
  if (term.editado) return <span className="pill status editado">Editado</span>;
  if (term.estadoOrigen)
    return (
      <span className={`pill status ${term.estadoOrigen}`}>{BADGE_LABEL[term.estadoOrigen]}</span>
    );
  return null;
}

function Fields({ term }: { term: AdminTerm }) {
  const bd = formatBdFields(term.camposBd);
  const sl = term.campoSoftland.trim();
  if (!bd && !sl)
    return (
      <div className="admin-row-fields">
        <b>Campos</b>sin completar
      </div>
    );
  return (
    <div className="admin-row-fields">
      <b>BD</b>
      {bd || '—'}
      <span className="sep">|</span>
      <b>Softland</b>
      {sl || '—'}
      {term.maestros.length > 0 && (
        <>
          <span className="sep">|</span>
          <b>Maestro</b>
          {term.maestros.join(', ')}
        </>
      )}
    </div>
  );
}

export function AdminTermRow({ term, confirming, onEdit, onDelete, onRestore }: AdminTermRowProps) {
  return (
    <div className="admin-row">
      <div className="admin-row-main">
        <div className="admin-row-term">
          {term.termino} <StatusLabel term={term} />
        </div>
        <div className="admin-row-tags">
          <TagPills names={term.etiquetas} />
        </div>
        <Fields term={term} />
      </div>
      <div className="admin-row-actions">
        {term.eliminado ? (
          <button type="button" className="admin-btn" onClick={() => onRestore(term.id)}>
            Restaurar
          </button>
        ) : (
          <>
            <button type="button" className="admin-btn" onClick={() => onEdit(term)}>
              Editar
            </button>
            <button
              type="button"
              className={`admin-btn danger${confirming ? ' confirm' : ''}`}
              onClick={() => onDelete(term.id)}
            >
              {confirming ? '¿Confirmar?' : 'Eliminar'}
            </button>
          </>
        )}
      </div>
    </div>
  );
}
