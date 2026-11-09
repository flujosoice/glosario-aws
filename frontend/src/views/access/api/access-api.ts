import { axiosApiGateway } from '../../../shared/api/axios-api-gateway';

export interface Access {
  puedeAdministrar: boolean;
  etiqueta: string | null;
}

export const accessApi = {
  /** GET /me: la API valida la llave del enlace de administración (si la hay). */
  async get(options: { signal?: AbortSignal } = {}): Promise<Access> {
    const { data } = await axiosApiGateway.get<Access>('/me', { signal: options.signal });
    return data;
  },
};
