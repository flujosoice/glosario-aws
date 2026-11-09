import { axiosApiGateway } from '../../../shared/api/axios-api-gateway';
import type { AdminTerm } from '../../glossary/api/glossary-api';

export type MatchStatus = 'pendiente' | 'aplicada' | 'descartada';
export type Confidence = 'Alta' | 'Media' | 'Baja';

export interface MatchOption {
  columna: string;
  etiqueta: string;
  tabla: string;
  modulo: string;
  descripcion: string;
  nTablas: number;
  otrasTablas: string[];
  observacion: string;
}

export interface MatchChoice {
  columna: string;
  tabla: string;
  etiqueta: string;
  maestro: string;
}

export interface DictionaryMatch {
  id: string;
  terminoId: string;
  termino: string;
  confianza: Confidence | null;
  orden: number;
  estado: MatchStatus;
  maestroSugerido: string;
  opciones: MatchOption[];
  elegido: MatchChoice | null;
  decididoEn: string | null;
  decididoPor: string | null;
}

export interface ApplyResult {
  coincidencia: DictionaryMatch;
  termino: AdminTerm;
}

type Options = { signal?: AbortSignal };

export const dictionaryApi = {
  async list(options: Options = {}): Promise<DictionaryMatch[]> {
    const { data } = await axiosApiGateway.get<DictionaryMatch[]>('/admin/dictionary-matches', {
      signal: options.signal,
    });
    return data;
  },
  async apply(matchId: string, choice: MatchChoice): Promise<ApplyResult> {
    const { data } = await axiosApiGateway.post<ApplyResult>(
      `/admin/dictionary-matches/${matchId}/apply`,
      choice,
    );
    return data;
  },
  async discard(matchId: string): Promise<DictionaryMatch> {
    const { data } = await axiosApiGateway.post<DictionaryMatch>(
      `/admin/dictionary-matches/${matchId}/discard`,
    );
    return data;
  },
  async reopen(matchId: string): Promise<DictionaryMatch> {
    const { data } = await axiosApiGateway.post<DictionaryMatch>(
      `/admin/dictionary-matches/${matchId}/reopen`,
    );
    return data;
  },
  /** Busca columnas en el Diccionario de Softland sincronizado en Aurora. */
  async search(q: string, options: Options = {}): Promise<MatchOption[]> {
    const { data } = await axiosApiGateway.get<MatchOption[]>('/admin/softland-dictionary', {
      params: { q },
      signal: options.signal,
    });
    return data;
  },
};
