import { useOutletContext } from 'react-router-dom';
import { BookIcon, GridIcon, ListIcon } from '../../../shared/ui/icons';
import { ErrorState, LoadingState } from '../../../shared/ui/state-views';
import { useAccess } from '../../access/components/access-provider';
import { GlossarySidebar } from '../components/glossary-sidebar';
import { HelpFab } from '../components/help-fab';
import { TermList } from '../components/term-list';
import { TermModal } from '../components/term-modal';
import { useGlossaryController } from '../hooks/use-glossary-controller';

export interface LayoutContext {
  sidebarOpen: boolean;
}

export function GlossaryPage() {
  const g = useGlossaryController();
  const { canAdmin } = useAccess();
  const { sidebarOpen } = useOutletContext<LayoutContext>();
  const shown = g.visibleIds.size;
  const total = g.terms.length;

  return (
    <div className="shell">
      <div className="page-head">
        <div>
          <h1>Glosario de Términos</h1>
          <p className="page-sub">
            Sistema de Información Mayoreo — Cofersa · Febeca · Sillaca · Beval · Mundi Partes
          </p>
        </div>
        <div className="head-controls">
          <div className="view-toggle">
            <button
              type="button"
              className={g.view === 'grid' ? 'active' : ''}
              title="Vista de tarjetas"
              aria-label="Vista de tarjetas"
              onClick={() => g.setView('grid')}
            >
              <GridIcon />
            </button>
            <button
              type="button"
              className={g.view === 'list' ? 'active' : ''}
              title="Vista de lista"
              aria-label="Vista de lista"
              onClick={() => g.setView('list')}
            >
              <ListIcon />
            </button>
          </div>
          <div className="result-count">
            <BookIcon size={15} />
            <span>
              {shown === total ? `${shown} términos encontrados` : `${shown} de ${total} términos`}
            </span>
          </div>
        </div>
      </div>

      <div className="stat-row">
        <span className="stat-chip">
          <b>{total}</b>Términos
        </span>
      </div>

      <div className={`layout${sidebarOpen ? '' : ' no-sidebar'}`}>
        <GlossarySidebar
          filters={g.filters}
          origenTags={g.origenTags}
          simTags={g.simTags}
          masters={g.masters}
          counts={g.counts}
          onQuery={g.setQuery}
          onToggleTag={g.toggleTag}
          onMaestro={g.setMaestro}
          onFields={g.setFields}
          onClear={g.clearFilters}
        />
        <main>
          {g.loading && <LoadingState message="Cargando el glosario…" />}
          {g.error && <ErrorState message={g.error} onRetry={g.reload} />}
          {!g.loading && !g.error && (
            <>
              <TermList
                terms={g.terms}
                visibleIds={g.visibleIds}
                view={g.view}
                onOpen={g.openTerm}
              />
              {shown === 0 && (
                <div className="empty-state">Ningún término coincide con los filtros actuales.</div>
              )}
            </>
          )}
        </main>
      </div>

      {g.selected && (
        <TermModal
          term={g.selected}
          canAdmin={canAdmin}
          saveError={g.saveError}
          onClose={g.closeTerm}
          onSaveFields={g.saveFields}
        />
      )}
      <HelpFab />
    </div>
  );
}
