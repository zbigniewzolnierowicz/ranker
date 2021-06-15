defmodule Ranker.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :name, :string

      timestamps()
    end

  end
end
