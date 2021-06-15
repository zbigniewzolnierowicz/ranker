defmodule RankerWeb.UserView do
  use RankerWeb, :view
  alias RankerWeb.UserView
  alias RankerWeb.RewardView
  alias Ranker.Authentication.User
  alias Ranker.PointTrading.Pool
  alias Ranker.PointTrading.Reward

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: %User{pool: %Ecto.Association.NotLoaded{}, rewards: [%Reward{}]} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points,
      rewards: render_many(user.rewards, RewardView, "reward.json")}
  end

  def render("user.json", %{user: %User{pool: %Pool{}, rewards: %Ecto.Association.NotLoaded{}} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points,
      pool: render(user.pool, UserView, "pool.json")}
  end

  def render("user.json", %{user: %User{pool: %Ecto.Association.NotLoaded{}, rewards: %Ecto.Association.NotLoaded{}} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points}
  end

  def render("user.json", %{user: %User{} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points,
      rewards: render_many(user.rewards, RewardView, "reward.json"),
      pool: render_one(user.pool, RankerWeb.PoolView, "pool.json")}
  end
end
