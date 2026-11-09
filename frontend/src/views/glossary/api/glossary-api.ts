import { axiosApiGateway } from '../../../shared/api/axios-api-gateway';

export type OriginFlag = 'fusionado' | 'homonimo' | 'dudoso' | 'sinetiqueta';

export interface BdField {
  campo: string;
  aplicaA: string;
}

export interface Fragment {
  contexto: string;
  texto: string;
}

/** Término tal como lo ve el enlace general. */
export interface Term {
  id: string;
  termino: string;
  definicion: string;
  fragmentos: Fragment[];
  etiquetas: string[];
  estadoOrigen: OriginFlag | null;
  camposBd: BdField[];
  campoSoftland: string;
  maestros: string[];
  esNuevo: boolean;
}

/** Término con los datos de Administración (Editado, Eliminado). */
export interface AdminTerm extends Term {
  editado: boolean;
  eliminado: boolean;
  actualizadoEn: string | null;
}

export interface TermInput {
  termino: string;
  definicion: string;
  etiquetas: string[];
  camposBd: BdField[];
  campoSoftland: string;
  maestros: string[];
}

type Options = { signal?: AbortSignal };

export const glossaryApi = {
  async list(options: Options = {}): Promise<Term[]> {
    const { data } = await axiosApiGateway.get<Term[]>('/terms', { signal: options.signal });
    return data;
  },
  async listAdmin(options: Options = {}): Promise<AdminTerm[]> {
    const { data } = await axiosApiGateway.get<AdminTerm[]>('/admin/terms', {
      signal: options.signal,
    });
    return data;
  },
  async create(input: TermInput, options: Options = {}): Promise<AdminTerm> {
    const { data } = await axiosApiGateway.post<AdminTerm>('/admin/terms', input, options);
    return data;
  },
  async update(termId: string, input: TermInput, options: Options = {}): Promise<AdminTerm> {
    const { data } = await axiosApiGateway.put<AdminTerm>(`/admin/terms/${termId}`, input, options);
    return data;
  },
  async remove(termId: string, options: Options = {}): Promise<AdminTerm> {
    const { data } = await axiosApiGateway.delete<AdminTerm>(`/admin/terms/${termId}`, options);
    return data;
  },
  async restore(termId: string, options: Options = {}): Promise<AdminTerm> {
    const { data } = await axiosApiGateway.post<AdminTerm>(
      `/admin/terms/${termId}/restore`,
      null,
      options,
    );
    return data;
  },
};
