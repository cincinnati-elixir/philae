defmodule DDPHandler do
  use Behaviour

  defmacro __using__(_) do
    quote location: :keep do
      require Logger

      def added(_pid, message) do
        log(message)
      end

      def removed(_pid, message) do
        log(message)
      end

      def changed(_pid, message) do
        log(message)
      end

      def result(_pid, message) do
        log(message)
      end

      def connected(_pid, message) do
        log(message)
      end

      def ready(_pid, message) do
        log(message)
      end

      def updated(_pid, message) do
        log(message)
      end

      def nosub(_pid, message) do
        log(message)
      end

      def error(_pid, message) do
        log(message)
      end

      defp log(message) do
        Logger.info "In: " <> inspect message
      end

      defoverridable [ added: 2, removed: 2, changed: 2, result: 2, connected: 2,
        ready: 2, updated: 2, nosub: 2, error: 2 ]
    end
  end
end
