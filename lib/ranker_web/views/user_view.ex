defmodule RankerWeb.UserView do
  use RankerWeb, :view
  alias RankerWeb.UserView
  alias Ranker.Authentication.User
  alias Ranker.PointTrading.Pool

  def render("index.json", %{users: users}) do
    render_many(users, UserView, "user.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, UserView, "user.json")
  end

  def render("user.json", %{user: %User{pool: %Ecto.Association.NotLoaded{}} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points}
  end

  def render("user.json", %{user: %User{pool: %Pool{}} = user}) do
    %{id: user.id,
      name: user.name,
      email: user.email,
      provider: user.provider,
      spendable_points: user.spendable_points,
      pool: %{
        month: user.pool.month,
        year: user.pool.year,
        points: user.pool.points
      }}
  end
end
