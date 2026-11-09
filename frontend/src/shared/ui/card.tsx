import type { ReactNode } from 'react';

export interface CardProps {
  title?: string;
  actions?: ReactNode;
  children: ReactNode;
}

export function Card({ title, actions, children }: CardProps) {
  return (
    <section className="ui-card">
      {(title || actions) && (
        <header className="ui-card-header">
          {title && <h2 className="ui-card-title">{title}</h2>}
          {actions}
        </header>
      )}
      {children}
    </section>
  );
}
