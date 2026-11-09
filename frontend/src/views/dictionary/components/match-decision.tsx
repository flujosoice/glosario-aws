import type { DictionaryMatch } from '../api/dictionary-api';
import { NEW_MASTER, type MatchDraft } from '../hooks/use-dictionary-controller';

interface MatchDecisionProps {
  match: DictionaryMatch;
  draft: MatchDraft;
  masters: string[];
  busy: boolean;
  error: string | null;
  onDraft: (patch: Partial<MatchDraft>) => void;
  onApply: () => void;
  onDiscard: () => void;
  onSkip: () => void;
  onReopen: () => void;
}

/** Campos editables antes de confirmar, o el estado de una coincidencia ya decidida. */
export function MatchDecision(p: MatchDecisionProps) {
  if (p.match.estado !== 'pendiente') {
    const e = p.match.elegido;
    return (
      <>
        <div className="sug-status">
          {p.match.estado === 'aplicada' ? (
            <>
              Aplicada
              {e && (
                <>
                  : <code>{e.columna}</code> (tabla {e.tabla})
                </>
              )}
              .
            </>
          ) : (
            'Descartada.'
          )}
        </div>
        {p.error && (
          <div className="form-error" role="alert">
            {p.error}
          </div>
        )}
        <div className="sug-actions">
          <button type="button" className="admin-btn" disabled={p.busy} onClick={p.onReopen}>
            Volver a pendiente
          </button>
        </div>
      </>
    );
  }
  const options = [...p.masters];
  if (p.draft.mae && p.draft.mae !== NEW_MASTER && !options.includes(p.draft.mae))
    options.push(p.draft.mae);
  return (
    <>
      <div className="sug-form">
        <div>
          <label htmlFor="sug-bd">Campo en Base de Datos</label>
          <input
            id="sug-bd"
            type="text"
            className="mono"
            value={p.draft.bd}
            onChange={(e) => p.onDraft({ bd: e.target.value })}
          />
        </div>
        <div>
          <label htmlFor="sug-sl">Campo en Softland</label>
          <input
            id="sug-sl"
            type="text"
            value={p.draft.sl}
            onChange={(e) => p.onDraft({ sl: e.target.value })}
          />
        </div>
        <div>
          <label htmlFor="sug-mae">Maestro de origen</label>
          <select
            id="sug-mae"
            value={p.draft.mae}
            onChange={(e) => p.onDraft({ mae: e.target.value })}
          >
            <option value="">Sin maestro</option>
            {options.map((m) => (
              <option key={m} value={m}>
                {m}
              </option>
            ))}
            <option value={NEW_MASTER}>Otro maestro…</option>
          </select>
          {p.draft.mae === NEW_MASTER && (
            <input
              type="text"
              className="extra"
              autoFocus
              value={p.draft.maeNuevo}
              aria-label="Nombre del nuevo maestro"
              onChange={(e) => p.onDraft({ maeNuevo: e.target.value })}
            />
          )}
        </div>
      </div>
      {p.error && (
        <div className="form-error" role="alert">
          {p.error}
        </div>
      )}
      <div className="sug-actions">
        <button type="button" className="admin-btn danger" disabled={p.busy} onClick={p.onDiscard}>
          Descartar
        </button>
        <button type="button" className="admin-btn" onClick={p.onSkip}>
          Saltar
        </button>
        <button type="button" className="admin-btn primary" disabled={p.busy} onClick={p.onApply}>
          Aplicar al término
        </button>
      </div>
    </>
  );
}
