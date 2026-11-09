import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';
import { App } from './app/app';
import { setupAccess } from './shared/access/access-key';
import './styles/global.css';

// Sin Cognito: toma la llave del enlace de administración (si la hay) antes de la primera llamada a la API.
setupAccess();

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <App />
  </StrictMode>,
);
