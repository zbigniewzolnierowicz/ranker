defmodule Ranker.AuthenticationTest do
  use Ranker.DataCase

  alias Ranker.Authentication

  describe "users" do
    alias Ranker.Authentication.User

    @valid_attrs %{email: "some email", name: "some name", provider: "some provider", token: "some token"}
    @update_attrs %{email: "some updated email", name: "some updated name", provider: "some updated provider", token: "some updated token"}
    @invalid_attrs %{email: nil, name: nil, provider: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Authentication.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Authentication.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Authentication.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Authentication.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.provider == "some provider"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Authentication.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Authentication.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.provider == "some updated provider"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Authentication.update_user(user, @invalid_attrs)
      assert user == Authentication.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Authentication.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Authentication.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Authentication.change_user(user)
    end
  end
end
