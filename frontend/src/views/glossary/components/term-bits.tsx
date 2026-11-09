import type { Term } from '../api/glossary-api';
import { BADGE_LABEL, bdSummary } from '../model/term-rules';

export function StatusPill({ term }: { term: Term }) {
  if (term.esNuevo) return <span className="pill status nuevo">Nuevo</span>;
  if (term.estadoOrigen)
    return (
      <span className={`pill status ${term.estadoOrigen}`}>{BADGE_LABEL[term.estadoOrigen]}</span>
    );
  return null;
}

/** Los términos fusionados muestran su definición por contexto de origen. */
export function DefinitionText({ term }: { term: Term }) {
  if (term.fragmentos.length === 0) return <>{term.definicion}</>;
  return (
    <>
      {term.fragmentos.map((f, i) => (
        <div className="def-frag" key={i}>
          <span className="def-tag">{f.contexto}</span>
          {f.texto}
        </div>
      ))}
    </>
  );
}

/** Solo los términos con Campo BD o Softland lo muestran al pie de la tarjeta. */
export function CardFields({ term }: { term: Term }) {
  const bd = bdSummary(term.camposBd);
  const sl = term.campoSoftland.trim();
  if (!bd && !sl) return null;
  return (
    <div className="card-fields">
      {bd && (
        <div>
          <b>BD</b>
          <code>{bd}</code>
        </div>
      )}
      {sl && (
        <div>
          <b>Softland</b>
          <code>{sl}</code>
        </div>
      )}
    </div>
  );
}

export function RowFields({ term }: { term: Term }) {
  const bd = bdSummary(term.camposBd);
  const sl = term.campoSoftland.trim();
  if (!bd && !sl) return null;
  return (
    <div className="row-fields">
      {bd && (
        <>
          BD <code>{bd}</code>
        </>
      )}
      {bd && sl && ' · '}
      {sl && (
        <>
          Softland <code>{sl}</code>
        </>
      )}
    </div>
  );
}
