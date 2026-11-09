import { SearchBox } from '../../../shared/ui/search-box';
import { AdminTermRow } from '../components/admin-term-row';
import { TermForm } from '../components/term-form';
import { useAdminTermsController } from '../hooks/use-admin-terms-controller';

/** Pestaña Términos de Administración · Procesos. */
export function AdminTermsPage() {
  const c = useAdminTermsController();
  const total = c.rows.length;

  return (
    <>
      <div className="admin-toolbar">
        <button type="button" className="admin-btn primary" onClick={c.openNew}>
          + Nuevo término
        </button>
        <div style={{ flex: 1, minWidth: 180 }}>
          <SearchBox
            id="admin-search"
            value={c.query}
            label="Buscar término"
            placeholder="Buscar término…"
            onChange={c.setQuery}
          />
        </div>
      </div>

      {c.form && (
        <TermForm
          key={c.form.key}
          form={c.form}
          origenTags={c.origenTags}
          simTags={c.simTags}
          masters={c.masters}
          error={c.formError}
          saving={c.saving}
          onChange={c.setForm}
          onCancel={c.cancel}
          onSave={c.save}
        />
      )}
      {c.actionError && (
        <p className="form-error" role="alert">
          {c.actionError}
        </p>
      )}

      <p className="page-sub" style={{ margin: '0 0 10px' }}>
        {total > c.limit
          ? `Mostrando ${c.limit} de ${total} términos.`
          : `${total} término${total === 1 ? '' : 's'}`}
      </p>
      <div className="admin-rows">
        {c.shownRows.length ? (
          c.shownRows.map((term) => (
            <AdminTermRow
              key={term.id}
              term={term}
              confirming={c.confirming.has(term.id)}
              onEdit={c.openEdit}
              onDelete={c.requestDelete}
              onRestore={c.restore}
            />
          ))
        ) : (
          <div className="empty-state compact">Ningún término coincide.</div>
        )}
      </div>
      {total > c.limit && (
        <div className="admin-more">
          <button type="button" className="admin-btn" onClick={c.showMore}>
            Mostrar {Math.min(150, total - c.limit)} más
          </button>
          <button type="button" className="admin-btn" onClick={c.showAll}>
            Mostrar todos ({total})
          </button>
        </div>
      )}
    </>
  );
}
