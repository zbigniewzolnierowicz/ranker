defmodule Ranker.Authentication.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ranker.PointTrading.Pool
  alias Ranker.PointTrading.Reward
  alias Ranker.Authentication.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :provider, :string
    field :token, :string
    field :spendable_points, :integer
    field :role, Ecto.Enum, values: [user: "user", admin: "admin"]

    has_one :pool, Pool
    many_to_many :rewards, Reward, join_through: "user_rewards"

    timestamps()
  end

  @doc """
    Changeset used as a default
  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :provider, :token, :spendable_points, :role])
    |> validate_required([:email, :name, :provider, :token, :spendable_points, :role])
  end

  @doc """
    Changeset used when creating a new user
  """
  def changeset_new_user(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :provider, :token, :role])
    |> validate_required([:name, :email, :provider, :token])
  end

  def changeset_add_reward(%User{} = user, attrs) do
    user
    |> change()
    |> cast(attrs, [:spendable_points])
    |> cast_assoc(:rewards)
    |> validate_required([:spendable_points, :rewards])
  end

  def changeset_update_points(%User{} = user, _attrs) do
    user
    |> change()
    |> cast_assoc(:pool)
    |> validate_required([:pool])
  end
end
