export function toggleValue(list: string[], value: string): string[] {
  return list.includes(value) ? list.filter((v) => v !== value) : [...list, value];
}

interface CheckListProps {
  items: string[];
  selected: string[];
  empty: string;
  onToggle: (value: string) => void;
}

/** Casillas de etiquetas o maestros del formulario de términos. */
export function CheckList({ items, selected, empty, onToggle }: CheckListProps) {
  if (!items.length) return <p className="muted-note">{empty}</p>;
  return (
    <>
      {items.map((t) => (
        <label className="tag-picker-item" key={t}>
          <input type="checkbox" checked={selected.includes(t)} onChange={() => onToggle(t)} />
          <span>{t}</span>
        </label>
      ))}
    </>
  );
}
