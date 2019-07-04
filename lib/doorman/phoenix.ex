defmodule Doorman.Phoenix do
  defmacro __using__(%{policy: policy} = opts) do
    quote do
      use Doorman.Base, policy: policy
    end
  end

  # defmacro authorize(function, opts) do
  #   case _authorize(function, opts) do
  #     true -> {:ok, nil}
  #     false -> {:error, :unauthorized}
  #   end
  # end

  # defmacro _authorize(function, opts) do
  #   policy_module = unquote(opts[:policy])
  #   apply(policy_module, function, [opts])
  # end
end