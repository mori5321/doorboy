# Doorboy
## Description
Doorboy is a simple and lightweight library for authorization.

## Usage
### 1. Define policy file for each Controller. And define Authorization-Function.

Authorization-Function
- can be freely named
- is recommended to be named with corresponding controller's action name. 

if Authorization-Function returns true, it returns {:ok, nil}.
if not, it returns {:error, :unauthorized}.

``` hoge_controller_policy.ex
defmodule Sample.HogeControllerPolicy do
  # Authorization-Function
  #
  # If this function returns true. Function 'authorize' in your controller returns {:ok, nil}
  # If this function returns false . Function 'authorize' in your controller returns {:error, :unauthorized}
  def update(user: user, clip: clip) do
    user.id == clip.user_id
  end
end

```

### 2. You can call your Authorization-Function in your controller with 'authorize'.

1. set "use Doorboy, policy: YourPolicyFile"  in your Controller
2. call **authorize** method wherever you like.

``` hoge_controller.ex

defmodule Sample.HogeController do
  use Doorboy, policy: Sample.HogeControllerPolicy

  def update(conn, params) do
    with {:ok, clip} <- Hoge.fetch_clip(params.id),
         {:ok, _} <- authorize(:update, user: conn.assigns.current_user, clip: clip), #authorize! 
         ...
    do
      ...
    else
      {:error, :unauthorized} -> ...
    end
  end
end

```

#### authorize/2
authorize(authorize_function_name, opts)

```
authorize(:update, user: user, clips: clips)

# returns {:ok, nil} or {:error, :unauthorized}
```


#### authorize!/2
authorize!(authorize_function_name, opts)

```
authorize!(:update, user: user, clips: clips)

# returns {:ok, nil} or raise AuthorizationError

```


## Installation

The package can be installed by adding `doorman` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:doorboy, "~> 0.1.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/doorman](https://hexdocs.pm/doorman).

