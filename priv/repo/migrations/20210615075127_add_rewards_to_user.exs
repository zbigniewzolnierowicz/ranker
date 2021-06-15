defmodule Ranker.Repo.Migrations.AddRewardsToUser do
  use Ecto.Migration

  def change do
    create table(:user_rewards, primary_key: false) do
      add :user_id, references(:users)
      add :reward_id, references(:rewards)

      timestamps()
    end
  end
end
