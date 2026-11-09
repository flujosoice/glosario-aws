/** Íconos de trazo del glosario original (SVG en línea, heredan el color del texto). */
import type { ReactNode } from 'react';

interface IconProps {
  size?: number;
}

function Svg({
  size = 16,
  width = 2,
  children,
}: IconProps & { width?: number; children: ReactNode }) {
  return (
    <svg
      width={size}
      height={size}
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      strokeWidth={width}
      aria-hidden="true"
    >
      {children}
    </svg>
  );
}

export function SidebarIcon() {
  return (
    <Svg size={19} width={1.8}>
      <rect x="3" y="4" width="18" height="16" rx="2.4" />
      <line x1="9.5" y1="4" x2="9.5" y2="20" />
    </Svg>
  );
}

export function BookIcon({ size = 14 }: IconProps) {
  return (
    <Svg size={size}>
      <path d="M4 5.5c2-1 5-1 8 0v13c-3-1-6-1-8 0z" />
      <path d="M20 5.5c-2-1-5-1-8 0v13c3-1 6-1 8 0z" />
    </Svg>
  );
}

export function LockIcon({ size = 14 }: IconProps) {
  return (
    <Svg size={size} width={2.2}>
      <rect x="5" y="11" width="14" height="9" rx="2" />
      <path d="M8 11V8a4 4 0 0 1 8 0v3" />
    </Svg>
  );
}

export function SunIcon() {
  return (
    <Svg size={18} width={1.8}>
      <circle cx="12" cy="12" r="4.2" />
      <path d="M12 2.5v2.2M12 19.3v2.2M4.2 4.2l1.55 1.55M18.25 18.25l1.55 1.55M2.5 12h2.2M19.3 12h2.2M4.2 19.8l1.55-1.55M18.25 5.75l1.55-1.55" />
    </Svg>
  );
}

export function MoonIcon() {
  return (
    <Svg size={18} width={1.8}>
      <path d="M20 14.5A8.5 8.5 0 0 1 9.5 4 8.5 8.5 0 1 0 20 14.5z" />
    </Svg>
  );
}

export function UserIcon() {
  return (
    <Svg size={16} width={1.8}>
      <circle cx="12" cy="8" r="3.6" />
      <path d="M4.5 20c1.4-3.8 4.4-5.8 7.5-5.8s6.1 2 7.5 5.8" />
    </Svg>
  );
}

export function GridIcon() {
  return (
    <Svg>
      <rect x="3" y="3" width="7.5" height="7.5" rx="1.4" />
      <rect x="13.5" y="3" width="7.5" height="7.5" rx="1.4" />
      <rect x="3" y="13.5" width="7.5" height="7.5" rx="1.4" />
      <rect x="13.5" y="13.5" width="7.5" height="7.5" rx="1.4" />
    </Svg>
  );
}

export function ListIcon() {
  return (
    <Svg>
      <line x1="4" y1="6" x2="20" y2="6" />
      <line x1="4" y1="12" x2="20" y2="12" />
      <line x1="4" y1="18" x2="20" y2="18" />
    </Svg>
  );
}

export function SearchIcon() {
  return (
    <Svg size={15}>
      <circle cx="11" cy="11" r="7" />
      <path d="M21 21l-4-4" />
    </Svg>
  );
}

export function ChevronIcon() {
  return (
    <Svg size={13} width={2.2}>
      <path d="M6 9l6 6 6-6" />
    </Svg>
  );
}

export function CloseIcon() {
  return (
    <Svg>
      <line x1="5" y1="5" x2="19" y2="19" />
      <line x1="19" y1="5" x2="5" y2="19" />
    </Svg>
  );
}

export function HelpIcon() {
  return (
    <Svg size={22} width={1.8}>
      <circle cx="12" cy="12" r="9.2" />
      <path d="M9.3 9.3a2.7 2.7 0 1 1 3.9 2.4c-.9.5-1.2 1-1.2 1.9" />
      <circle cx="12" cy="17" r=".25" fill="currentColor" stroke="none" />
    </Svg>
  );
}
