defmodule RankerWeb.AuthController do
  use RankerWeb, :controller
  plug Ueberauth

  alias Ranker.Authentication
  alias Ranker.Authentication.User

  action_fallback RankerWeb.FallbackController

  def identity_callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
    IO.puts auth
    IO.puts params
    text conn, "Unimplemented"
  end
end
