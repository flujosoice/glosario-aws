import { useState } from 'react';

interface AddNameRowProps {
  id: string;
  placeholder: string;
  busy: boolean;
  error: string | null | undefined;
  onAdd: (name: string) => Promise<boolean>;
}

/** Campo + "Agregar" (también con Enter); se limpia solo si se guardó. */
export function AddNameRow({ id, placeholder, busy, error, onAdd }: AddNameRowProps) {
  const [value, setValue] = useState('');
  const submit = async () => {
    if (await onAdd(value)) setValue('');
  };
  return (
    <>
      <div className="tag-add-row">
        <input
          id={id}
          type="text"
          value={value}
          placeholder={placeholder}
          aria-label={placeholder}
          onChange={(e) => setValue(e.target.value)}
          onKeyDown={(e) => {
            if (e.key === 'Enter') {
              e.preventDefault();
              submit();
            }
          }}
        />
        <button type="button" className="admin-btn primary" disabled={busy} onClick={submit}>
          Agregar
        </button>
      </div>
      {error && (
        <div className="tag-add-error" role="alert">
          {error}
        </div>
      )}
    </>
  );
}
