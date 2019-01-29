defmodule PocketReducer do
  @moduledoc """
  PocketReducer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias PocketReducer.Reducer

  def archive(items) do
    items
    |> Reducer.take_older_than_year()
    |> Enum.map(fn {_, %{"item_id" => id}} ->
      %{action: "archive", item_id: id}
    end)
  end
end
