defmodule Ranker.Repo.Migrations.UpdatePoolUserIdName do
  use Ecto.Migration

  def change do
    rename table(:pools), :user, to: :user_id
  end
end
