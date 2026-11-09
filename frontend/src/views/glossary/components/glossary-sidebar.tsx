import { SearchBox } from '../../../shared/ui/search-box';
import { SIN_DEFINIR, type FieldsFilter, type TermFilters } from '../model/term-rules';
import { TagDropdown } from './tag-dropdown';

interface GlossarySidebarProps {
  filters: TermFilters;
  origenTags: string[];
  simTags: string[];
  masters: string[];
  counts: Record<string, number>;
  onQuery: (q: string) => void;
  onToggleTag: (kind: 'origen' | 'sim', tag: string) => void;
  onMaestro: (m: string) => void;
  onFields: (f: FieldsFilter) => void;
  onClear: () => void;
}

export function GlossarySidebar(props: GlossarySidebarProps) {
  const { filters, counts } = props;
  return (
    <aside className="sidebar">
      <div className="field-block">
        <label className="field-label" htmlFor="search">
          Buscar término
        </label>
        <SearchBox
          id="search"
          value={filters.query}
          label="Buscar término"
          placeholder="Término, etiqueta o campo BD/Softland…"
          onChange={props.onQuery}
        />
      </div>
      <div className="field-block">
        <p className="field-label">Silo / Sistema de Origen</p>
        <TagDropdown
          label="Silo / Sistema de Origen"
          tags={props.origenTags}
          selected={filters.origen}
          counts={counts}
          onToggle={(t) => props.onToggleTag('origen', t)}
        />
      </div>
      <div className="field-block">
        <p className="field-label">Rol en Reporte SIM</p>
        <TagDropdown
          label="Rol en Reporte SIM"
          tags={props.simTags}
          selected={filters.sim}
          counts={counts}
          onToggle={(t) => props.onToggleTag('sim', t)}
        />
      </div>
      <div className="field-block">
        <label className="field-label" htmlFor="maestro-filter">
          Maestro de origen
        </label>
        <select
          id="maestro-filter"
          className="side-select"
          value={filters.maestro}
          onChange={(e) => props.onMaestro(e.target.value)}
        >
          <option value="">Todos</option>
          {props.masters.map((m) => (
            <option key={m} value={m}>
              {m}
            </option>
          ))}
          <option value={SIN_DEFINIR}>Sin definir</option>
        </select>
      </div>
      <div className="field-block">
        <label className="field-label" htmlFor="fields-filter">
          Campo BD / Softland
        </label>
        <select
          id="fields-filter"
          className="side-select"
          value={filters.fields}
          onChange={(e) => props.onFields(e.target.value as FieldsFilter)}
        >
          <option value="">Todos</option>
          <option value="con">Con campo BD / Softland</option>
          <option value="sin">Sin campo BD / Softland</option>
        </select>
      </div>
      <button type="button" className="clear-filters" onClick={props.onClear}>
        Quitar todos los filtros
      </button>
    </aside>
  );
}
