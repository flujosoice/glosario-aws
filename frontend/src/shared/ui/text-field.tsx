import { useId, type InputHTMLAttributes } from 'react';

export interface TextFieldProps extends InputHTMLAttributes<HTMLInputElement> {
  label: string;
  error?: string | null;
}

export function TextField({ label, error, id, ...rest }: TextFieldProps) {
  const generated = useId();
  const inputId = id ?? generated;
  return (
    <label className="ui-field" htmlFor={inputId}>
      <span>{label}</span>
      <input id={inputId} className="ui-input" aria-invalid={Boolean(error)} {...rest} />
      {error && <span className="ui-field-error">{error}</span>}
    </label>
  );
}
