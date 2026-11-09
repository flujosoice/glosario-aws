import { axiosApiGateway } from '../../../shared/api/axios-api-gateway';

export type TagType = 'silo_sistema' | 'rol_reporte_sim';

export interface Tag {
  id: number;
  nombre: string;
  tipo: TagType;
  esBase: boolean;
}

export interface Master {
  id: number;
  nombre: string;
  esBase: boolean;
}

export interface Catalogs {
  etiquetas: Tag[];
  maestros: Master[];
}

type Options = { signal?: AbortSignal };

export const catalogsApi = {
  async get(options: Options = {}): Promise<Catalogs> {
    const { data } = await axiosApiGateway.get<Catalogs>('/catalogs', { signal: options.signal });
    return data;
  },
  async createTag(nombre: string, tipo: TagType): Promise<Tag> {
    const { data } = await axiosApiGateway.post<Tag>('/admin/tags', { nombre, tipo });
    return data;
  },
  async deleteTag(tagId: number): Promise<void> {
    await axiosApiGateway.delete(`/admin/tags/${tagId}`);
  },
  async createMaster(nombre: string): Promise<Master> {
    const { data } = await axiosApiGateway.post<Master>('/admin/masters', { nombre });
    return data;
  },
  async deleteMaster(masterId: number): Promise<void> {
    await axiosApiGateway.delete(`/admin/masters/${masterId}`);
  },
};
