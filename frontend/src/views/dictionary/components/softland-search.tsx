import type { MatchOption } from '../api/dictionary-api';
import { useSoftlandSearchController } from '../hooks/use-softland-search-controller';

/** "Buscar otra columna": agrega candidatas del diccionario vigente a la coincidencia. */
export function SoftlandSearch({ onPick }: { onPick: (o: MatchOption) => void }) {
  const s = useSoftlandSearchController();
  return (
    <div className="sug-search">
      <div className="tag-add-row">
        <input
          type="text"
          value={s.query}
          placeholder="Buscar otra columna en el diccionario…"
          aria-label="Buscar otra columna en el diccionario de Softland"
          onChange={(e) => s.setQuery(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              e.preventDefault();
              s.search();
            }
          }}
        />
        <button type="button" className="admin-btn" disabled={s.loading} onClick={s.search}>
          {s.loading ? 'Buscando…' : 'Buscar'}
        </button>
      </div>
      {s.error && (
        <div className="tag-add-error" role="alert">
          {s.error}
        </div>
      )}
      {s.results && s.results.length === 0 && (
        <p className="muted-note">Sin resultados en el diccionario sincronizado.</p>
      )}
      {s.results?.map((o) => (
        <button
          type="button"
          key={`${o.columna}-${o.tabla}`}
          className="sug-opt"
          style={{ width: '100%', textAlign: 'left', background: 'none', color: 'inherit' }}
          onClick={() => {
            onPick(o);
            s.reset();
          }}
        >
          <div>
            <code>{o.columna}</code>
            {o.etiqueta && ` · ${o.etiqueta}`}
            <div className="meta">
              Tabla {o.tabla}
              {o.modulo && ` · Módulo ${o.modulo}`} · aparece en {o.nTablas} tabla
              {o.nTablas === 1 ? '' : 's'}
            </div>
          </div>
        </button>
      ))}
    </div>
  );
}
