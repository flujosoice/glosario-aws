/**
 * Llave de acceso del enlace de administración (sin Cognito).
 *
 * El Portal Interno Mayoreo abre la app con `/administracion#llave=<valor>`. El fragmento (#) no viaja al
 * servidor ni queda en los registros de Amplify. Se guarda en sessionStorage (o en memoria si el navegador
 * lo bloquea dentro del iframe), se quita de la barra de direcciones y se envía a la API como
 * `Authorization: Llave <valor>`. El enlace general no trae llave y la API lo trata como solo lectura.
 */
import { setAccessTokenProvider } from '../api/axios-api-gateway';

const STORAGE_KEY = 'glosario-llave-v1';
const HASH_PARAM = 'llave';
let memoryKey: string | null = null;

function readStored(): string | null {
  try {
    return sessionStorage.getItem(STORAGE_KEY);
  } catch {
    return memoryKey;
  }
}

function store(key: string): void {
  memoryKey = key;
  try {
    sessionStorage.setItem(STORAGE_KEY, key);
  } catch {
    // almacenamiento bloqueado (iframe de terceros): queda en memoria mientras la página esté abierta
  }
}

export function captureAccessKeyFromUrl(): void {
  const params = new URLSearchParams(window.location.hash.replace(/^#/, ''));
  const key = params.get(HASH_PARAM)?.trim();
  if (!key) return;
  store(key);
  params.delete(HASH_PARAM);
  const rest = params.toString();
  const clean = window.location.pathname + window.location.search + (rest ? `#${rest}` : '');
  window.history.replaceState(window.history.state, '', clean);
}

export function getAccessKey(): string | null {
  return readStored() ?? memoryKey;
}

/** Se llama una vez en el entrypoint, antes de la primera llamada a la API. */
export function setupAccess(): void {
  captureAccessKeyFromUrl();
  setAccessTokenProvider(async () => {
    const key = getAccessKey();
    return key ? `Llave ${key}` : null;
  });
}
