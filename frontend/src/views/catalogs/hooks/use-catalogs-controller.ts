import { useMemo, useState } from 'react';
import { normalizeError } from '../../../shared/api/api-error';
import { useAdminData } from '../../glossary/components/admin-data-provider';
import { catalogsApi, type TagType } from '../api/catalogs-api';

export type { Tag, TagType } from '../api/catalogs-api';

/** Conteos de términos activos y regla de borrado; el catálogo vive en los datos de Administración. */
export function useCatalogsController() {
  const { terms, catalogs, setCatalogs, dropTag } = useAdminData();
  const [errors, setErrors] = useState<Record<string, string | null>>({});
  const [busy, setBusy] = useState(false);

  const active = useMemo(() => terms.filter((t) => !t.eliminado), [terms]);
  const tagCounts = useMemo(() => {
    const counts: Record<string, number> = {};
    for (const t of active) for (const e of t.etiquetas) counts[e] = (counts[e] ?? 0) + 1;
    return counts;
  }, [active]);
  const masterCounts = useMemo(() => {
    const counts: Record<string, number> = {};
    for (const t of active) for (const m of t.maestros) counts[m] = (counts[m] ?? 0) + 1;
    return counts;
  }, [active]);
  /** Un maestro se elimina solo sin términos, incluidos los eliminados (siguen referenciándolo). */
  const masterInUse = useMemo(() => {
    const used = new Set<string>();
    for (const t of terms) for (const m of t.maestros) used.add(m);
    return used;
  }, [terms]);

  const attempt = async (scope: string, action: () => Promise<void>): Promise<boolean> => {
    setErrors((e) => ({ ...e, [scope]: null }));
    setBusy(true);
    try {
      await action();
      return true;
    } catch (e) {
      setErrors((x) => ({ ...x, [scope]: normalizeError(e).message }));
      return false;
    } finally {
      setBusy(false);
    }
  };

  const exists = (name: string, list: string[]) =>
    list.some((n) => n.toLowerCase() === name.trim().toLowerCase());

  const addTag = (tipo: TagType, nombre: string) => {
    if (!nombre.trim()) return Promise.resolve(false);
    if (
      exists(
        nombre,
        catalogs.etiquetas.map((t) => t.nombre),
      )
    ) {
      setErrors((e) => ({ ...e, [tipo]: 'Ya existe una etiqueta con ese nombre.' }));
      return Promise.resolve(false);
    }
    return attempt(tipo, async () => {
      const tag = await catalogsApi.createTag(nombre.trim(), tipo);
      setCatalogs((c) => ({ ...c, etiquetas: [...c.etiquetas, tag] }));
    });
  };

  const removeTag = (tagId: number, tipo: TagType) =>
    attempt(tipo, async () => {
      await catalogsApi.deleteTag(tagId);
      const removed = catalogs.etiquetas.find((t) => t.id === tagId);
      if (removed) dropTag(removed.nombre);
      setCatalogs((c) => ({ ...c, etiquetas: c.etiquetas.filter((t) => t.id !== tagId) }));
    });

  const addMaster = (nombre: string) => {
    if (!nombre.trim()) return Promise.resolve(false);
    if (
      exists(
        nombre,
        catalogs.maestros.map((m) => m.nombre),
      )
    ) {
      setErrors((e) => ({ ...e, maestros: 'Ya existe un maestro con ese nombre.' }));
      return Promise.resolve(false);
    }
    return attempt('maestros', async () => {
      const master = await catalogsApi.createMaster(nombre.trim());
      setCatalogs((c) => ({ ...c, maestros: [...c.maestros, master] }));
    });
  };

  const removeMaster = (masterId: number) =>
    attempt('maestros', async () => {
      await catalogsApi.deleteMaster(masterId);
      setCatalogs((c) => ({ ...c, maestros: c.maestros.filter((m) => m.id !== masterId) }));
    });

  return {
    tags: catalogs.etiquetas,
    masters: catalogs.maestros,
    tagCounts,
    masterCounts,
    masterInUse,
    errors,
    busy,
    addTag,
    removeTag,
    addMaster,
    removeMaster,
  };
}
