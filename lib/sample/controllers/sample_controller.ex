defmodule Sample.Controllers.FeedController do
  use Doorboy, policy: Fuga.Policies.FeedControllerPolicy

  def create do
    user = %Sample.User{id: 1}
    feed = %Sample.Feed{id: 1, user_id: 2}

    authorize :create, user: user, feed: feed
  end

  def update do
    user = %Sample.User{id: 1}
    feed = %Sample.Feed{id: 1, user_id: 1}

    authorize :update, user: user, feed: feed
  end
end

