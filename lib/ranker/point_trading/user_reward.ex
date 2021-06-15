defmodule Ranker.PointTrading.UserReward do
  use Ecto.Schema

  schema "user_rewards" do
    belongs_to :user, Ranker.Authentication.User
    belongs_to :reward, Ranker.PointTrading.Reward
  end
end
