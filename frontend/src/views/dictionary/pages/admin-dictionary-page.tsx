import { EmptyState, ErrorState, LoadingState } from '../../../shared/ui/state-views';
import { MatchOptionsBox, MatchTermBox } from '../components/match-boxes';
import { MatchDecision } from '../components/match-decision';
import {
  useDictionaryController,
  type Confidence,
  type MatchStatus,
} from '../hooks/use-dictionary-controller';

const STATUS_FILTERS: [MatchStatus | '', string][] = [
  ['pendiente', 'Pendientes'],
  ['aplicada', 'Aplicadas'],
  ['descartada', 'Descartadas'],
  ['', 'Todas'],
];

/** Pestaña Diccionario Softland: revisión una por una; nada se aplica sin confirmación de Procesos. */
export function AdminDictionaryPage() {
  const d = useDictionaryController();
  if (d.loading) return <LoadingState message="Cargando las coincidencias…" />;
  if (d.error) return <ErrorState message={d.error} onRetry={d.reload} />;
  if (d.counts[''] === 0)
    return <EmptyState message="No hay coincidencias del diccionario para revisar." />;

  return (
    <>
      <p className="form-hint" style={{ margin: '0 0 12px' }}>
        Coincidencias entre los términos del glosario y el diccionario de datos de Softland.
        Revísalas una por una: al aplicar, la COLUMNA se guarda como Campo en Base de Datos y el
        Valor etiqueta como Campo en Softland.
      </p>
      <div className="sug-progress">
        {STATUS_FILTERS.map(([key, label]) => (
          <button
            type="button"
            key={label}
            className={`admin-btn${d.status === key ? ' active' : ''}`}
            onClick={() => d.setStatus(key)}
          >
            {label} ({d.counts[key] ?? 0})
          </button>
        ))}
        <select
          className="admin-btn"
          aria-label="Confianza"
          value={d.conf}
          onChange={(e) => d.setConf(e.target.value as Confidence | '')}
        >
          <option value="">Todas las confianzas</option>
          {(['Alta', 'Media', 'Baja'] as const).map((c) => (
            <option key={c} value={c}>
              Confianza {c.toLowerCase()}
            </option>
          ))}
        </select>
      </div>

      {!d.current || !d.draft ? (
        <div className="empty-state compact">No quedan coincidencias en esta vista.</div>
      ) : (
        <>
          <div className="sug-nav">
            <div className="pos">
              Coincidencia <b>{d.index + 1}</b> de {d.list.length}{' '}
              <span className={`conf-pill ${d.current.confianza ?? ''}`}>
                Confianza {(d.current.confianza ?? '').toLowerCase()}
              </span>
            </div>
            <div className="buttons">
              <button type="button" className="admin-btn" disabled={d.index === 0} onClick={d.prev}>
                ← Anterior
              </button>
              <button
                type="button"
                className="admin-btn"
                disabled={d.index >= d.list.length - 1}
                onClick={d.next}
              >
                Siguiente →
              </button>
            </div>
          </div>
          <div className="sug-grid">
            <MatchTermBox term={d.term} fallbackName={d.current.termino} />
            <MatchOptionsBox
              options={d.options}
              selected={d.draft.opt}
              editable={d.current.estado === 'pendiente'}
              onPick={d.pickOption}
              onAdd={d.addOption}
            />
          </div>
          <MatchDecision
            match={d.current}
            draft={d.draft}
            masters={d.masters}
            busy={d.busy}
            error={d.actionError}
            onDraft={d.setDraft}
            onApply={d.apply}
            onDiscard={d.discard}
            onSkip={d.next}
            onReopen={d.reopen}
          />
        </>
      )}
    </>
  );
}
