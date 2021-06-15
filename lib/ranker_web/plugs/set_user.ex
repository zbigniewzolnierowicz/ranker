defmodule RankerWeb.Plugs.SetUser do
  import Plug.Conn
  alias Ranker.Repo
  alias Ranker.Authentication.User

  @spec init(any) :: any()
  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id)
    cond do
      user = user_id && Repo.get(User, user_id) ->
        conn
        |> assign(:user, user)
        |> assign(:user_id, user_id)
      true ->
        conn
        |> assign(:user, nil)
        |> assign(:user_id, nil)
    end
  end
end
