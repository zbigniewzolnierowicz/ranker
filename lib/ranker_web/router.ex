defmodule RankerWeb.Router do
  use RankerWeb, :router
  alias RankerWeb.Plugs.{SetUser}

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug SetUser
  end

  # Other scopes may use custom stacks.
  scope "/api", RankerWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit, :create]
    get "/users/:id/send/:send_to", UserController, :send_money
    resources "/rewards", RewardController, except: [:new, :edit]
    get "/users/:user_id/reward/:reward_id", RewardController, :buy_reward
  end

  scope "/auth", RankerWeb do
    pipe_through :browser

    get "/logout", AuthController, :logout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  scope "/", RankerWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  #   import Phoenix.LiveDashboard.Router

  #   scope "/" do
  #     pipe_through :browser
  #     live_dashboard "/dashboard", metrics: RankerWeb.Telemetry
  #   end
  # end
end
