defmodule FormsWeb.Router do
  use FormsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {FormsWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormsWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/", FormsWeb.Live.Accounts do
    pipe_through [:browser]

    live "/login", Login, :index
    live "/home", Home, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", FormsWeb do
  #   pipe_through :api
  # end
end
