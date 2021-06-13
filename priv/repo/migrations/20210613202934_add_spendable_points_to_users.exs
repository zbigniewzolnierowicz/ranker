defmodule Ranker.Repo.Migrations.AddSpendablePointsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :spendable_points, :integer, default: 0
    end
  end
end
