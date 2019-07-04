
defmodule Doorman do
  defmacro __using__(policy: policy) do
    quote do 
      def authorize(function, opts) do
        case _authorize(function, opts) do
          true -> {:ok, nil}
          false -> {:error, :unauthorized}
        end
      end

      def authorize!(function, opts) do
        case _authorize(function, opts) do
          true -> {:ok, nil}
          false -> raise Doorman.Exception.UnauthorizedError
        end
      end
    
      defp _authorize(function, opts) do
        policy_module = unquote(policy)
        apply(policy_module, function, [opts])
      end
    end
  end
end
