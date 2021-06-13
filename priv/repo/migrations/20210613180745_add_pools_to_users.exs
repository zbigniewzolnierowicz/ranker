defmodule Ranker.Repo.Migrations.AddPoolsToUsers do
  use Ecto.Migration

  def change do
    create table(:pools) do
      add :month, :integer
      add :year, :integer
      add :user, references(:users)
      add :points, :integer, default: 50
    end

    alter table(:users) do
      add :pool_id, references(:pools)
    end
  end
end
