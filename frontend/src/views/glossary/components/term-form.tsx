import { Link } from 'react-router-dom';
import type { TermFormDraft } from '../hooks/use-admin-data-controller';
import { CheckList, toggleValue } from './check-list';

interface TermFormProps {
  form: TermFormDraft;
  origenTags: string[];
  simTags: string[];
  masters: string[];
  error: string | null;
  saving: boolean;
  onChange: (form: TermFormDraft) => void;
  onCancel: () => void;
  onSave: () => void;
}

export function TermForm({
  form,
  origenTags,
  simTags,
  masters,
  error,
  saving,
  onChange,
  onCancel,
  onSave,
}: TermFormProps) {
  const set = (patch: Partial<TermFormDraft>) => onChange({ ...form, ...patch });
  const setRow = (i: number, patch: Partial<TermFormDraft['bdRows'][number]>) =>
    set({ bdRows: form.bdRows.map((r, j) => (j === i ? { ...r, ...patch } : r)) });
  const removeRow = (i: number) => {
    const rows = form.bdRows.filter((_, j) => j !== i);
    set({ bdRows: rows.length ? rows : [{ campo: '', aplicaA: '' }] });
  };
  const toggleTag = (t: string) => set({ etiquetas: toggleValue(form.etiquetas, t) });

  return (
    <div className="term-form">
      <div className="form-row">
        <label className="field-label" htmlFor="tf-term">
          Término
        </label>
        <input
          id="tf-term"
          type="text"
          value={form.termino}
          placeholder="Nombre del término"
          autoComplete="off"
          autoFocus
          onChange={(e) => set({ termino: e.target.value })}
        />
      </div>
      <div className="form-row">
        <label className="field-label" htmlFor="tf-def">
          Definición
        </label>
        <textarea
          id="tf-def"
          rows={3}
          value={form.definicion}
          placeholder="Definición del término"
          onChange={(e) => set({ definicion: e.target.value })}
        />
      </div>
      <div className="form-row">
        <p className="field-label">Etiquetas</p>
        <div className="tag-picker">
          <div className="tag-picker-group">
            <p className="tag-picker-title">Silo / Sistema de Origen</p>
            <CheckList
              items={origenTags}
              selected={form.etiquetas}
              empty="Sin etiquetas todavía."
              onToggle={toggleTag}
            />
          </div>
          <div className="tag-picker-group">
            <p className="tag-picker-title">Rol en Reporte SIM</p>
            <CheckList
              items={simTags}
              selected={form.etiquetas}
              empty="Sin etiquetas todavía."
              onToggle={toggleTag}
            />
          </div>
        </div>
      </div>
      <div className="form-row">
        <p className="field-label">Campo en Base de Datos</p>
        <div className="bd-rows">
          <div className="bd-head">
            <span>Campo</span>
            <span>Aplica a (empresa o tabla)</span>
            <span />
          </div>
          {form.bdRows.map((row, i) => (
            <div className="bd-row" key={i}>
              <input
                type="text"
                value={row.campo}
                aria-label="Campo en Base de Datos"
                onChange={(e) => setRow(i, { campo: e.target.value })}
              />
              <input
                type="text"
                className="bd-ctx"
                value={row.aplicaA}
                aria-label="Aplica a"
                onChange={(e) => setRow(i, { aplicaA: e.target.value })}
              />
              <button
                type="button"
                className="tag-del-btn"
                title="Quitar este campo"
                aria-label="Quitar este campo"
                onClick={() => removeRow(i)}
              >
                ×
              </button>
            </div>
          ))}
        </div>
        <button
          type="button"
          className="admin-btn"
          style={{ marginTop: 8 }}
          onClick={() => set({ bdRows: [...form.bdRows, { campo: '', aplicaA: '' }] })}
        >
          + Agregar otro campo
        </button>
        <p className="form-hint">
          Si el campo cambia según la empresa o la tabla, agrega una línea por cada caso e indica a
          qué aplica.
        </p>
      </div>
      <div className="form-row">
        <label className="field-label" htmlFor="tf-sl">
          Campo en Softland
        </label>
        <input
          id="tf-sl"
          type="text"
          value={form.campoSoftland}
          onChange={(e) => set({ campoSoftland: e.target.value })}
        />
      </div>
      <div className="form-row">
        <p className="field-label">Maestro de origen</p>
        <div className="tag-picker-group tall">
          <CheckList
            items={masters}
            selected={form.maestros}
            empty="Sin maestros todavía."
            onToggle={(m) => set({ maestros: toggleValue(form.maestros, m) })}
          />
        </div>
        <p className="form-hint">
          ¿Falta un maestro? Agrégalo en la pestaña{' '}
          <Link className="link-btn" to="/administracion/maestros">
            Maestros
          </Link>
          .
        </p>
      </div>
      {error && (
        <div className="form-error" role="alert">
          {error}
        </div>
      )}
      <div className="form-actions">
        <button type="button" className="admin-btn" onClick={onCancel}>
          Cancelar
        </button>
        <button type="button" className="admin-btn primary" disabled={saving} onClick={onSave}>
          {saving ? 'Guardando…' : form.id ? 'Guardar cambios' : 'Crear término'}
        </button>
      </div>
    </div>
  );
}
