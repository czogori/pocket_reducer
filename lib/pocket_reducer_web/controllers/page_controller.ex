defmodule PocketReducerWeb.PageController do
  use PocketReducerWeb, :controller
  require Logger
  alias PocketReducer.Auth

  def index(conn, _params) do
    access_token = get_session(conn, :access_token)

    render(
      conn,
      "index.html",
      authorized?: access_token !== nil,
      fetched?: false,
      welcome_text: "Wait, i'm fetching data from getpocket.com...",
      items_count: 0
    )
  end

  def auth(conn, _params) do
    request_token = Auth.get_request_token()

    conn
    |> put_session(:request_token, request_token)
    |> redirect(external: Auth.get_authorize_url(request_token))
  end

  def callback(conn, _params) do
    access_token =
      get_session(conn, :request_token)
      |> Auth.get_access_token()

    conn
    |> put_session(:access_token, access_token)
    |> redirect(to: "/")
  end
end
