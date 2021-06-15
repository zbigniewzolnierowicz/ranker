defmodule RankerWeb.RewardView do
  use RankerWeb, :view
  alias RankerWeb.RewardView
  alias Ranker.PointTrading.Reward

  def render("index.json", %{rewards: rewards}) do
    %{data: render_many(rewards, RewardView, "reward.json")}
  end

  def render("show.json", %{reward: reward}) do
    %{data: render_one(reward, RewardView, "reward.json")}
  end

  def render("reward.json", %{reward: %Reward{} = reward}) do
    %{id: reward.id,
      name: reward.name,
      price: reward.price}
  end
end
