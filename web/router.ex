defmodule Elasr.Router do
  use Elasr.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Elasr do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/tekstovi/new", TekstController, :new
    get "/tekstovi/:slug", TekstController, :show
    get "/tekstovi/edit/id/:id", TekstController, :edit
    get "/tekstovi/edit/name/:slug", TekstController, :editname
    
    resources "/brojevi", BrojController
    resources "/kategorije", KategorijaController
    resources "/autori", AutorController
    resources "/tekstovi", TekstController
    resources "/komentari", KomentarController
    #get "/:id", PageController, :index
    #get "/:id/:iad", PageController, :index
    #get "/:id/:iad/:bad", PageController, :index

  end

  # Other scopes may use custom stacks.
  # scope "/api", Elasr do
  #   pipe_through :api
  # end
end

