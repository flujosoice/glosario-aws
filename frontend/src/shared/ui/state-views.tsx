import { Button } from './button';

export function LoadingState({ message = 'Cargando…' }: { message?: string }) {
  return (
    <div className="ui-state" role="status">
      {message}
    </div>
  );
}

export function ErrorState({ message, onRetry }: { message: string; onRetry?: () => void }) {
  return (
    <div className="ui-state ui-state--error" role="alert">
      <p>{message}</p>
      {onRetry && (
        <Button variant="secondary" onClick={onRetry}>
          Reintentar
        </Button>
      )}
    </div>
  );
}

export function EmptyState({ message }: { message: string }) {
  return <div className="ui-state">{message}</div>;
}
