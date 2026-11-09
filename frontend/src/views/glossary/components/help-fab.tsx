import { useEffect, useRef, useState } from 'react';
import { HelpIcon } from '../../../shared/ui/icons';

/** Botón de ayuda: explica los estados de las tarjetas. */
export function HelpFab() {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!open) return;
    const close = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    document.addEventListener('click', close);
    return () => document.removeEventListener('click', close);
  }, [open]);

  return (
    <div ref={ref}>
      <button
        type="button"
        className="fab"
        title="Cómo usar el glosario"
        aria-label="Ayuda"
        aria-expanded={open}
        onClick={() => setOpen((v) => !v)}
      >
        <HelpIcon />
      </button>
      {open && (
        <div className="help-panel">
          <h3>Cómo leer las tarjetas</h3>
          <p>
            El color de cada etiqueta es solo para distinguirlas rápido; no tiene un significado
            fijo. Los estados sí lo tienen:
          </p>
          <div className="legend-row">
            <span className="pill status fusionado">Fusionado</span> varias filas del archivo
            original, un solo término.
          </div>
          <div className="legend-row">
            <span className="pill status homonimo">Homónimo</span> mismo nombre, conceptos distintos
            — se separó.
          </div>
          <div className="legend-row">
            <span className="pill status dudoso">Revisar</span> fusión que conviene confirmar.
          </div>
          <div className="legend-row">
            <span className="pill status sinetiqueta">Sin etiqueta</span> no se pudo inferir el silo
            de origen.
          </div>
        </div>
      )}
    </div>
  );
}
