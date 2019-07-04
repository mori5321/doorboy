defmodule Doorman.Exception do
  defmodule UnauthorizedError do
    defexception message: "Unauthorized Error"
  end
end