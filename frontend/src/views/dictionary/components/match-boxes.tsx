import { TagPills } from '../../../shared/ui/tag-pill';
import type { AdminTerm } from '../../glossary/api/glossary-api';
import { DefinitionText } from '../../glossary/components/term-bits';
import { formatBdFields, hasFields } from '../../glossary/model/term-rules';
import type { MatchOption } from '../api/dictionary-api';
import { SoftlandSearch } from './softland-search';

export function MatchTermBox({
  term,
  fallbackName,
}: {
  term: AdminTerm | null;
  fallbackName: string;
}) {
  const hasDefinition = !!term && (term.definicion || term.fragmentos.length > 0);
  return (
    <div className="sug-box">
      <h4>En el glosario</h4>
      <p className="sug-term">{term?.termino ?? fallbackName}</p>
      {term && (
        <div className="card-pills" style={{ justifyContent: 'flex-start', marginBottom: 8 }}>
          <TagPills names={term.etiquetas} />
        </div>
      )}
      <div className="sug-def">
        {hasDefinition && term ? (
          <DefinitionText term={term} />
        ) : (
          <span className="muted-note">Sin definición</span>
        )}
      </div>
      {term && hasFields(term) && (
        <div className="sug-warn">
          Este término ya tiene Campo en BD <code>{formatBdFields(term.camposBd) || '—'}</code> y
          Campo en Softland <code>{term.campoSoftland || '—'}</code>. Si aplicas, se reemplazan.
        </div>
      )}
    </div>
  );
}

interface OptionsBoxProps {
  options: MatchOption[];
  selected: number;
  editable: boolean;
  onPick: (i: number) => void;
  onAdd: (o: MatchOption) => void;
}

export function MatchOptionsBox({ options, selected, editable, onPick, onAdd }: OptionsBoxProps) {
  return (
    <div className="sug-box">
      <h4>En el diccionario de Softland{options.length > 1 ? ' · elige la columna' : ''}</h4>
      {options.map((o, i) => (
        <label
          className={`sug-opt${selected === i ? ' sel' : ''}`}
          key={`${o.columna}-${o.tabla}-${i}`}
        >
          <input
            type="radio"
            name="sug-opt"
            checked={selected === i}
            disabled={!editable}
            onChange={() => onPick(i)}
          />
          <div>
            <code>{o.columna}</code>
            {o.etiqueta && ` · ${o.etiqueta}`}
            <div className="meta">
              Tabla {o.tabla}
              {o.modulo && ` · Módulo ${o.modulo}`} · aparece en {o.nTablas} tabla
              {o.nTablas === 1 ? '' : 's'}
            </div>
            <div className="desc">
              {o.descripcion || (
                <span className="muted-note">Sin descripción en el diccionario</span>
              )}
            </div>
            {o.observacion && <div className="meta warn">{o.observacion}</div>}
          </div>
        </label>
      ))}
      {editable && <SoftlandSearch onPick={onAdd} />}
    </div>
  );
}
