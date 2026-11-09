import { useId, type SelectHTMLAttributes } from 'react';

export interface SelectFieldProps extends SelectHTMLAttributes<HTMLSelectElement> {
  label: string;
  options: { value: string; label: string }[];
  hideLabel?: boolean;
}

export function SelectField({ label, options, hideLabel = false, id, ...rest }: SelectFieldProps) {
  const generated = useId();
  const selectId = id ?? generated;
  return (
    <label className="ui-field" htmlFor={selectId}>
      {!hideLabel && <span>{label}</span>}
      <select id={selectId} className="ui-select" aria-label={label} {...rest}>
        {options.map((option) => (
          <option key={option.value} value={option.value}>
            {option.label}
          </option>
        ))}
      </select>
    </label>
  );
}
