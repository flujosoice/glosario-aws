import { useEffect, useState } from 'react';
import { CloseIcon } from '../../../shared/ui/icons';
import { TagPills } from '../../../shared/ui/tag-pill';
import type { BdField, Term } from '../api/glossary-api';
import { DefinitionText, StatusPill } from './term-bits';

interface TermModalProps {
  term: Term;
  canAdmin: boolean;
  saveError: string | null;
  onClose: () => void;
  onSaveFields: (term: Term, camposBd: BdField[], campoSoftland: string) => void;
}

/** Ficha del término. Procesos corrige aquí Campo BD / Softland; quien consulta no ve casillas vacías. */
export function TermModal({ term, canAdmin, saveError, onClose, onSaveFields }: TermModalProps) {
  const [fields, setFields] = useState<BdField[]>(term.camposBd);
  const [softland, setSoftland] = useState(term.campoSoftland);

  useEffect(() => {
    setFields(term.camposBd);
    setSoftland(term.campoSoftland);
  }, [term]);

  useEffect(() => {
    const onKey = (e: KeyboardEvent) => e.key === 'Escape' && onClose();
    document.addEventListener('keydown', onKey);
    return () => document.removeEventListener('keydown', onKey);
  }, [onClose]);

  const variants = fields.length > 1 ? fields : [fields[0] ?? { campo: '', aplicaA: '' }];
  const showFields = canAdmin || fields.length > 0 || softland.trim() !== '';
  const save = () => {
    const clean = variants
      .filter((f) => f.campo.trim())
      .map((f) => ({ ...f, campo: f.campo.trim() }));
    const changed =
      JSON.stringify(clean) !== JSON.stringify(term.camposBd) ||
      softland.trim() !== term.campoSoftland;
    if (changed) onSaveFields(term, clean, softland.trim());
  };
  const setVariant = (i: number, campo: string) =>
    setFields(variants.map((f, j) => (j === i ? { ...f, campo } : f)));

  return (
    <div className="modal-overlay" onClick={(e) => e.target === e.currentTarget && onClose()}>
      <div className="modal" role="dialog" aria-modal="true" aria-labelledby="modal-term">
        <div className="modal-top">
          <span className="modal-term" id="modal-term">
            {term.termino}
          </span>
          <button type="button" className="modal-close" aria-label="Cerrar" onClick={onClose}>
            <CloseIcon />
          </button>
        </div>
        <div className="modal-pills">
          <TagPills names={term.etiquetas} />
          <StatusPill term={term} />
        </div>
        <div className="modal-def">
          <DefinitionText term={term} />
        </div>
        {showFields && (
          <div className="edit-grid">
            <div className="bd-variants">
              {variants.map((f, i) => {
                const label = `Campo en Base de Datos${f.aplicaA ? ` · ${f.aplicaA}` : ''}`;
                return (
                  <div className="edit-field" key={i}>
                    <label htmlFor={`bd-${i}`}>{label}</label>
                    {canAdmin ? (
                      <input
                        id={`bd-${i}`}
                        type="text"
                        value={f.campo}
                        onChange={(e) => setVariant(i, e.target.value)}
                        onBlur={save}
                      />
                    ) : (
                      <div className="ro-value" id={`bd-${i}`}>
                        {f.campo}
                      </div>
                    )}
                  </div>
                );
              })}
            </div>
            <div className="edit-field">
              <label htmlFor="softland">Campo en Softland</label>
              {canAdmin ? (
                <input
                  id="softland"
                  type="text"
                  value={softland}
                  onChange={(e) => setSoftland(e.target.value)}
                  onBlur={save}
                />
              ) : (
                <div className="ro-value" id="softland">
                  {softland}
                </div>
              )}
            </div>
          </div>
        )}
        {saveError && (
          <p className="form-error" role="alert">
            {saveError}
          </p>
        )}
      </div>
    </div>
  );
}
