defmodule RankerWeb.RewardController do
  use RankerWeb, :controller

  alias Ranker.PointTrading
  alias Ranker.PointTrading.Reward

  action_fallback RankerWeb.FallbackController

  plug RankerWeb.Plugs.RequireLogin when action in [:index, :show, :buy_reward]
  plug :require_owner_of_account when action in [:buy_reward]

  def index(conn, _params) do
    rewards = PointTrading.list_rewards()
    render(conn, "index.json", rewards: rewards)
  end

  def create(conn, %{"reward" => reward_params}) do
    with {:ok, %Reward{} = reward} <- PointTrading.create_reward(reward_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.reward_path(conn, :show, reward))
      |> render("show.json", reward: reward)
    end
  end

  def show(conn, %{"id" => id}) do
    reward = PointTrading.get_reward!(id)
    render(conn, "show.json", reward: reward)
  end

  def update(conn, %{"id" => id, "reward" => reward_params}) do
    reward = PointTrading.get_reward!(id)

    with {:ok, %Reward{} = reward} <- PointTrading.update_reward(reward, reward_params) do
      render(conn, "show.json", reward: reward)
    end
  end

  def delete(conn, %{"id" => id}) do
    reward = PointTrading.get_reward!(id)

    with {:ok, %Reward{}} <- PointTrading.delete_reward(reward) do
      send_resp(conn, :no_content, "")
    end
  end

  def buy_reward(conn, %{"user_id" => user_id, "reward_id" => reward_id}) do
    reward =
      try do
        PointTrading.get_reward!(reward_id)
      rescue
        _e in Ecto.NoResultsError ->
          conn
          |> put_status(404)
          |> put_view(RankerWeb.ErrorView)
          |> render("404.json", message: "Reward not found.", details: "A reward with this ID does not exist.")
      end
    user =
      try do
        Ranker.Authentication.get_user_with_rewards!(user_id)
      rescue
        _e in Ecto.NoResultsError ->
          conn
          |> put_status(404)
          |> put_view(RankerWeb.ErrorView)
          |> render("404.json", message: "User not found.", details: "A user with this ID does not exist.")
      end
    conn = Phoenix.Controller.put_view(conn, RankerWeb.UserView)
    cond do
      Enum.member?(user.rewards, reward) ->
        conn
        |> put_status(202)
        |> render("show.json", user: user)
      user.spendable_points < reward.price ->
        conn
        |> put_status(409)
        |> put_view(RankerWeb.ErrorView)
        |> render("409.json", message: "Not enough points.", details: "You do not have enough spending points.")
      true ->
        with {:ok, user} <- PointTrading.buy_reward(user, reward) do
          conn
          |> put_status(201)
          |> render("show.json", user: user)
        end
    end
  end

  def require_owner_of_account(conn, _params) do
    try do
      %{params: %{"user_id" => user_id}} = conn
      user_id = String.to_integer(user_id)
      current_user_id = conn.assigns[:user_id]
      if user_id == current_user_id do
        conn
      else
        conn
        |> put_status(401)
        |> put_view(RankerWeb.ErrorView)
        |> render("401.json", message: "You are not the owner of this resouce.", details: "Your user ID must match the user ID in the path.")
        |> halt()
      end
    rescue
      _e in ArgumentError ->
        conn
        |> put_status(400)
        |> put_view(RankerWeb.ErrorView)
        |> render("400.json", message: "Incorrect user ID.", details: "User ID must be numerical.")
        |> halt()
    end
  end
end
