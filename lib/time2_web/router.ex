defmodule Time2Web.Router do
  use Time2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/ajax", Time2Web do
    pipe_through :ajax
    get "/", PageController, :index
    get "/daysheets/:id", DaysheetController, :show

    resources "/users", UserController, except: [:new, :edit]
    resources "/daysheets", DaysheetController, except: [:new, :edit]

    resources "/jobs", JobController, except: [:new, :edit]
    resources "/tasks", TaskController, except: [:new, :edit]
    resources "/sessions", SessionController, only: [:create], singleton: true
  end

  scope "/", Time2Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Time2Web do
  #   pipe_through :api
  # end
end
