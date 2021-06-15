defmodule Ranker.PointTrading.Pool do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ranker.Authentication.User

  schema "pools" do
    field :month, :integer
    field :year, :integer
    field :points, :integer, default: 50

    belongs_to :user, User
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:month, :year, :points])
    |> validate_required([:month, :year])
  end
end
