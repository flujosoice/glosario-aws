import { memo } from 'react';
import { TagPills } from '../../../shared/ui/tag-pill';
import type { Term } from '../api/glossary-api';
import type { ViewMode } from '../model/term-rules';
import { CardFields, DefinitionText, RowFields, StatusPill } from './term-bits';

interface TermListProps {
  terms: Term[];
  visibleIds: Set<string>;
  view: ViewMode;
  onOpen: (id: string) => void;
}

interface ItemProps {
  term: Term;
  hidden: boolean;
  onOpen: (id: string) => void;
}

const TermCard = memo(function TermCard({ term, hidden, onOpen }: ItemProps) {
  return (
    <button type="button" className="card" hidden={hidden} onClick={() => onOpen(term.id)}>
      <div className="card-top">
        <span className="card-term">{term.termino}</span>
        <div className="card-pills">
          <TagPills names={term.etiquetas} />
        </div>
      </div>
      <div className="card-def">
        <DefinitionText term={term} />
      </div>
      <CardFields term={term} />
      <div className="card-foot">
        <StatusPill term={term} />
      </div>
    </button>
  );
});

const TermRow = memo(function TermRow({ term, hidden, onOpen }: ItemProps) {
  return (
    <button type="button" className="row" hidden={hidden} onClick={() => onOpen(term.id)}>
      <div className="row-main">
        <div className="row-top">
          <span className="row-term">{term.termino}</span>
          <StatusPill term={term} />
        </div>
        <div className="row-def">{term.definicion}</div>
        <RowFields term={term} />
      </div>
      <div className="row-pills">
        <TagPills names={term.etiquetas} />
      </div>
    </button>
  );
});

/** Se dibujan todas las tarjetas una vez y el filtro solo las oculta (como el original). */
export function TermList({ terms, visibleIds, view, onOpen }: TermListProps) {
  const Item = view === 'grid' ? TermCard : TermRow;
  return (
    <div className={`term-list ${view}`}>
      {terms.map((term) => (
        <Item key={term.id} term={term} hidden={!visibleIds.has(term.id)} onOpen={onOpen} />
      ))}
    </div>
  );
}
