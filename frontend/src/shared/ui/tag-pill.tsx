const PALETTE_SIZE = 12;

/** Mismo hash que el glosario original: cada etiqueta conserva su color en las dos versiones. */
function tagColor(name: string): number {
  let h = 0;
  for (let i = 0; i < name.length; i++) h = (h * 31 + name.charCodeAt(i)) | 0;
  return Math.abs(h) % PALETTE_SIZE;
}

export function TagPill({ name }: { name: string }) {
  return <span className={`pill tag-c${tagColor(name)}`}>{name}</span>;
}

export function TagPills({ names }: { names: string[] }) {
  return (
    <>
      {names.map((name) => (
        <TagPill key={name} name={name} />
      ))}
    </>
  );
}
