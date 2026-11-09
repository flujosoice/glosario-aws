import { useCallback, useEffect, useState } from 'react';

const THEME_KEY = 'glosario-sim-theme-v1';
type Theme = 'light' | 'dark';

function systemPrefersDark(): boolean {
  return window.matchMedia('(prefers-color-scheme: dark)').matches;
}

function readSaved(): Theme | null {
  try {
    const value = localStorage.getItem(THEME_KEY);
    return value === 'light' || value === 'dark' ? value : null;
  } catch {
    return null;
  }
}

/** Tema claro/oscuro: sigue al sistema hasta que la persona elige uno (se recuerda en este navegador). */
export function useTheme(): { isDark: boolean; toggle: () => void } {
  const [saved, setSaved] = useState<Theme | null>(readSaved);
  const [systemDark, setSystemDark] = useState(systemPrefersDark);

  useEffect(() => {
    const media = window.matchMedia('(prefers-color-scheme: dark)');
    const onChange = () => setSystemDark(media.matches);
    media.addEventListener('change', onChange);
    return () => media.removeEventListener('change', onChange);
  }, []);

  useEffect(() => {
    if (saved) document.documentElement.setAttribute('data-theme', saved);
    else document.documentElement.removeAttribute('data-theme');
  }, [saved]);

  const isDark = saved ? saved === 'dark' : systemDark;
  const toggle = useCallback(() => {
    const next: Theme = isDark ? 'light' : 'dark';
    setSaved(next);
    try {
      localStorage.setItem(THEME_KEY, next);
    } catch {
      // sin almacenamiento el tema dura lo que dure la página
    }
  }, [isDark]);

  return { isDark, toggle };
}
