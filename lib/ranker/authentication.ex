defmodule Ranker.Authentication do
  @moduledoc """
  The Authentication context.
  """

  import Ecto.Query, warn: false
  alias Ranker.Repo

  alias Ranker.Authentication.User
  alias Ranker.PointTrading.Pool

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(from u in User, order_by: u.inserted_at)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  defp preload_pool(%User{} = user), do: user |> Repo.preload(:pool)

  defp preload_rewards(%User{} = user), do: user |> Repo.preload(:rewards)

  def get_user_with_pool!(id) do
    Repo.get!(User, id) |> preload_pool()
  end

  def get_user_with_rewards!(id) do
    Repo.get!(User, id) |> preload_rewards()
  end

  def get_user_with_everything!(id) do
    Repo.get!(User, id)
    |> preload_rewards()
    |> preload_pool()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def new_user_change(%User{} = user, attrs \\ %{}) do
    User.changeset_new_user(user, attrs)
  end

  def upsert_user(attrs \\ %{}) do
    changeset = new_user_change(%User{}, attrs)
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        today = Date.utc_today()
        Ecto.Multi.new()
        |> Ecto.Multi.insert(:user, changeset)
        |> Ecto.Multi.insert(:pool,
          fn %{user: user} ->
            Ecto.build_assoc(user, :pool)
            |> Pool.changeset(%{month: today.month, year: today.year})
          end
        )
        |> Repo.transaction()
      user ->
        {:ok, %{user: user}}
    end
  end

  def send_points_to_user(%User{pool: %Pool{} = pool}, %User{} = to, amount) do
    Ecto.Multi.new()
    |> Ecto.Multi.update(:pool, Pool.changeset(pool, %{points: pool.points - amount}))
    |> Ecto.Multi.update(:user, User.changeset(to, %{spendable_points: to.spendable_points + amount}))
    |> Repo.transaction()
  end
end
