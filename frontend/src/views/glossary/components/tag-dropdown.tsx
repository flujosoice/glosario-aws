import { useEffect, useRef, useState } from 'react';
import { ChevronIcon } from '../../../shared/ui/icons';

interface TagDropdownProps {
  label: string;
  tags: string[];
  selected: Set<string>;
  counts: Record<string, number>;
  onToggle: (tag: string) => void;
}

/** Selección múltiple de etiquetas con el número de términos de cada una. */
export function TagDropdown({ label, tags, selected, counts, onToggle }: TagDropdownProps) {
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

  const summary =
    selected.size === 0
      ? 'Seleccionar opciones'
      : `${selected.size} seleccionada${selected.size > 1 ? 's' : ''}`;

  return (
    <div className={`dropdown${open ? ' open' : ''}`} ref={ref}>
      <button
        type="button"
        className={`dropdown-btn${selected.size ? ' has-value' : ''}`}
        aria-expanded={open}
        aria-label={`${label}: ${summary}`}
        onClick={() => setOpen((v) => !v)}
      >
        <span>{summary}</span>
        <ChevronIcon />
      </button>
      {open && (
        <div className="dropdown-panel">
          {tags.map((tag) => (
            <label className="dropdown-item" key={tag}>
              <input type="checkbox" checked={selected.has(tag)} onChange={() => onToggle(tag)} />
              <span>{tag}</span>
              <span className="count">{counts[tag] ?? 0}</span>
            </label>
          ))}
        </div>
      )}
    </div>
  );
}
