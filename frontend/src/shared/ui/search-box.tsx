import { SearchIcon } from './icons';

interface SearchBoxProps {
  id: string;
  value: string;
  placeholder: string;
  label: string;
  onChange: (value: string) => void;
}

/** Campo de búsqueda con lupa (filtros del glosario y lista de Administración). */
export function SearchBox({ id, value, placeholder, label, onChange }: SearchBoxProps) {
  return (
    <div className="search-wrap">
      <SearchIcon />
      <input
        id={id}
        className="search-input"
        type="text"
        value={value}
        placeholder={placeholder}
        aria-label={label}
        autoComplete="off"
        onChange={(e) => onChange(e.target.value)}
      />
    </div>
  );
}
