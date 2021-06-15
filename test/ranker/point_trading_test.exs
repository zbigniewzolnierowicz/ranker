defmodule Ranker.PointTradingTest do
  use Ranker.DataCase

  alias Ranker.PointTrading

  describe "rewards" do
    alias Ranker.PointTrading.Reward

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def reward_fixture(attrs \\ %{}) do
      {:ok, reward} =
        attrs
        |> Enum.into(@valid_attrs)
        |> PointTrading.create_reward()

      reward
    end

    test "list_rewards/0 returns all rewards" do
      reward = reward_fixture()
      assert PointTrading.list_rewards() == [reward]
    end

    test "get_reward!/1 returns the reward with given id" do
      reward = reward_fixture()
      assert PointTrading.get_reward!(reward.id) == reward
    end

    test "create_reward/1 with valid data creates a reward" do
      assert {:ok, %Reward{} = reward} = PointTrading.create_reward(@valid_attrs)
      assert reward.name == "some name"
    end

    test "create_reward/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PointTrading.create_reward(@invalid_attrs)
    end

    test "update_reward/2 with valid data updates the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{} = reward} = PointTrading.update_reward(reward, @update_attrs)
      assert reward.name == "some updated name"
    end

    test "update_reward/2 with invalid data returns error changeset" do
      reward = reward_fixture()
      assert {:error, %Ecto.Changeset{}} = PointTrading.update_reward(reward, @invalid_attrs)
      assert reward == PointTrading.get_reward!(reward.id)
    end

    test "delete_reward/1 deletes the reward" do
      reward = reward_fixture()
      assert {:ok, %Reward{}} = PointTrading.delete_reward(reward)
      assert_raise Ecto.NoResultsError, fn -> PointTrading.get_reward!(reward.id) end
    end

    test "change_reward/1 returns a reward changeset" do
      reward = reward_fixture()
      assert %Ecto.Changeset{} = PointTrading.change_reward(reward)
    end
  end
end
