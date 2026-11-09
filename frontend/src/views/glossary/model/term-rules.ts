/** Reglas de consulta del glosario (las mismas que la versión de claude.ai; ver CLAUDE.md del paquete). */
import type { Master, Tag } from '../../catalogs/api/catalogs-api';
import type { BdField, OriginFlag, Term, TermInput } from '../api/glossary-api';

export const SIN_DEFINIR = '__sin_definir__';
export type FieldsFilter = '' | 'con' | 'sin';
export type ViewMode = 'grid' | 'list';

export interface TermFilters {
  query: string;
  origen: Set<string>;
  sim: Set<string>;
  maestro: string;
  fields: FieldsFilter;
}

export const BADGE_LABEL: Record<OriginFlag, string> = {
  fusionado: 'Fusionado',
  homonimo: 'Homónimo',
  dudoso: 'Revisar',
  sinetiqueta: 'Sin etiqueta',
};

export function sortTerms<T extends Term>(terms: T[]): T[] {
  return [...terms].sort((a, b) =>
    a.termino.toLowerCase().localeCompare(b.termino.toLowerCase(), 'es'),
  );
}

export function hasFields(term: Term): boolean {
  return term.camposBd.length > 0 || term.campoSoftland.trim() !== '';
}

/** "CAMPO" o "CAMPO_A (Aplica a) / CAMPO_B (Aplica a)", como se guardaba en el glosario original. */
export function formatBdFields(fields: BdField[]): string {
  if (fields.length === 1 && !fields[0].aplicaA) return fields[0].campo;
  return fields.map((f) => `${f.campo} (${f.aplicaA})`).join(' / ');
}

/** Resumen para tarjetas y lista: solo los nombres de campo. */
export function bdSummary(fields: BdField[]): string {
  return fields.map((f) => f.campo).join(' / ');
}

/** Busca en nombre, etiquetas, Campo BD y Campo Softland. Nunca en la definición (pedido de Procesos). */
export function searchText(term: Term): string {
  return [term.termino, term.etiquetas.join(' '), formatBdFields(term.camposBd), term.campoSoftland]
    .join(' ')
    .toLowerCase();
}

function anyTag(term: Term, selected: Set<string>): boolean {
  return selected.size === 0 || term.etiquetas.some((t) => selected.has(t));
}

export function matchesFilters(term: Term, f: TermFilters): boolean {
  const q = f.query.trim().toLowerCase();
  if (q && !searchText(term).includes(q)) return false;
  if (!anyTag(term, f.origen) || !anyTag(term, f.sim)) return false;
  if (f.fields === 'con' && !hasFields(term)) return false;
  if (f.fields === 'sin' && hasFields(term)) return false;
  if (f.maestro === SIN_DEFINIR) return term.maestros.length === 0;
  return !f.maestro || term.maestros.includes(f.maestro);
}

export function tagCounts(terms: Term[]): Record<string, number> {
  const counts: Record<string, number> = {};
  for (const term of terms) for (const t of term.etiquetas) counts[t] = (counts[t] ?? 0) + 1;
  return counts;
}

export function masterCounts(terms: Term[]): Record<string, number> {
  const counts: Record<string, number> = {};
  for (const term of terms) for (const m of term.maestros) counts[m] = (counts[m] ?? 0) + 1;
  return counts;
}

export function tagNames(tags: Tag[], tipo: Tag['tipo']): string[] {
  return tags
    .filter((t) => t.tipo === tipo)
    .map((t) => t.nombre)
    .sort((a, b) => a.localeCompare(b, 'es'));
}

export function masterNames(masters: Master[]): string[] {
  return masters.map((m) => m.nombre);
}

export function toInput(term: Term): TermInput {
  return {
    termino: term.termino,
    definicion: term.definicion,
    etiquetas: term.etiquetas,
    camposBd: term.camposBd,
    campoSoftland: term.campoSoftland,
    maestros: term.maestros,
  };
}
