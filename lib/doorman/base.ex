defmodule Doorman.Base do
  defmacro __using__(%{policy: policy} = _opts) do
    quote do
      def authorize(function, opts) do
        case _authorize(function, opts) do
          true -> {:ok, nil}
          false -> {:error, :unauthorized}
        end
      end

      def _authorize(function, opts) do
        policy_module = unquote(policy)
        apply(policy_module, function, [opts])
      end
    end
  end
end