# Doorboy
## Description
Doorboy is a simple and lightweight library for authorization.

## Usage
### 1. Define policy file for each Controller. And define Authorization-Function.

Authorization-Function
- can be freely naed
- is recommended to be named with corresponding controller's action name. 

if Authorization-Function returns true, it returns {:ok, nil}.
if not, it returns {:error, :unauthorized}.

```
defmodule Sample.HogeControllerPolicy do
  # ↓authorization function
  def update(user: user, clip: clip) do
    user.id == clip.user_id
  end
end

```

### 2. You can call your Authorization-Function in your controller with 'authorize'.

1. set "use Doorboy, policy: YourPolicyFile"  in your Controller
2. call authorize method wherever you like.

```

defmodule Sample.HogeController do
  use Doorboy, policy: Sample.HogeControllerPolicy

  def update(conn, params) do
    with {:ok, clip} <- Hoge.fetch_clip(params.id),
         {:ok, _} <- authorize(:update, user: conn.assigns.current_user, clip: clip),
         .....
    do
      ....
    else
      {:error, :unauthorized} -> ....
    end
  end
end

```

authorize function returns {:ok, nil} if Sample.HogeControllerPolicy.update/2 returns true
authorize function returns {:error, :unauthorized} if Sample.HogeControllerPolicy.update/2 returns false


**※authorize!**
You can also use "authorize!", which raises an AuthorizationError when AuthorizationFunction is false.




## Installation

The package can be installed by adding `doorman` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:doorboy, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/doorman](https://hexdocs.pm/doorman).

