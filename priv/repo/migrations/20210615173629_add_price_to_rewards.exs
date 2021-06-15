defmodule Ranker.Repo.Migrations.AddPriceToRewards do
  use Ecto.Migration

  def change do
    alter table(:rewards) do
      add :price, :integer
    end
  end
end
