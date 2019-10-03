
defmodule Doorboy do
  @moduledoc """
  Doorboy main module made with macro.
  """

  @doc """
  Use this module in your Phoenix Controller.

  ## Example
    defmodule SampleController do
      use Doorboy, policy: SamplePolicy

      def create(conn, params)
        book = Book.fetch(params.book_id)
        {:ok, _} <- authorize :create, user: conn.current_user, book: book
      end
    end
  
  
  Policy file looks like this.
  
  ## Example
    defmodule SamplePolicy do
      
      // If this function returns true, authorize/2 returns {:ok, nil}
      // If this function returns false, authorize/2 returns {:error, :unauthorized}
      def create(user: user, book: book) do
        user && user.id == book.user_id
      end
    end
  
  """
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
