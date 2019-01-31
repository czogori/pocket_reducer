defmodule PocketReducerWeb.PageCommander do
  use Drab.Commander
  alias PocketReducer.Api

  onload(:page_loaded)
  access_session(:access_token)

  def page_loaded(socket) do
    access_token = get_session(socket, :access_token)

    if access_token != nil do
      items = Api.all(access_token)
      count = Enum.count(items)
      Drab.Live.poke(socket, items_count: count, fetched?: access_token != nil)
    end
  end
end
