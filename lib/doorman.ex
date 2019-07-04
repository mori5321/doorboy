# Doorman ===================================

defmodule Doorman do
  defmacro __using__(%{policy: policy} = opts) do
    quote do
      use Doorman.Base, policy: policy
    end
  end
  # defmacro __using__(options) do
  #   policy = options[:policy]

  #   quote do 
  #     defmacro authorize(function, opts) do
  #       case _authorize(function, opts) do
  #         true -> {:ok, nil}
  #         false -> {:error, :unauthorized}
  #       end
  #     end
    
  #     defmacro _authorize(function, opts) do
  #       policy_module = unquote(opts[:policy])
  #       apply(policy_module, function, [opts])
  #     end
  #   end
  # end
end


defmodule Fuga.User do
  defstruct [:id]
end

defmodule Fuga.Feed do
  defstruct [:id, :user_id]
end

defmodule Fuga.FeedController do
  use Doorman, policy: Fuga.FeedController.Policy

  def create do
    user = %Fuga.User{id: 1}
    feed = %Fuga.Feed{id: 1, user_id: 2}

    authorize :create, user: user, feed: feed
  end

  def update do
    user = %Fuga.User{id: 1}
    feed = %Fuga.Feed{id: 1, user_id: 1}

    authorize :update, user: user, feed: feed
  end
end

defmodule Fuga.FeedController.Policy do
  def create(opts) do
    opts[:user] && opts[:feed].user_id == opts[:user].id
  end

  def update(opts) do
    opts[:user] && opts[:feed].user_id == opts[:user].id
  end
end
