defmodule Ranker.Authentication.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ranker.PointTrading.Pool
  alias Ranker.PointTrading.Reward

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string
    field :token, :string
    field :spendable_points, :integer

    has_one :pool, Pool
    many_to_many :rewards, Reward, join_through: "user_rewards"

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :provider, :token])
    |> validate_required([:name, :email, :provider, :token])
  end
end
