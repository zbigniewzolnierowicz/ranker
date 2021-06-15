defmodule RankerWeb.RewardController do
  use RankerWeb, :controller

  alias Ranker.PointTrading
  alias Ranker.PointTrading.Reward

  action_fallback RankerWeb.FallbackController

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
    reward = PointTrading.get_reward!(reward_id)
    user = Ranker.Authentication.get_user_with_rewards!(user_id)
    conn = Phoenix.Controller.put_view(conn, RankerWeb.UserView)
    cond do
      Enum.member?(user.rewards, reward) ->
        conn
        |> Plug.Conn.put_status(202)
        |> render("show.json", user: user)
      true ->
        with {:ok, user} <- PointTrading.buy_reward(user, reward) do
          conn
          |> Plug.Conn.put_status(201)
          |> render("show.json", user: user)
        end
    end

  end
end
