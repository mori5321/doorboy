defmodule Fuga.Policies.FeedControllerPolicy do
  def create(user: user, feed: feed) do
    user && user.id == feed.user_id
  end

  def update(user: user, feed: feed) do
    user && user.id == feed.user_id
  end
end
