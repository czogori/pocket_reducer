defmodule PocketReducerTest do
  use ExUnit.Case

  alias PocketReducer

  @now DateTime.utc_now() |> DateTime.to_unix()
  @year 60 * 60 * 24 * 365
  @year_ago @now - @year
  @more_than_year_ago @year_ago - 1

  @item %{
    "item_id" => "740050382",
    "time_added" => @more_than_year_ago |> Integer.to_string()
  }

  @items [
    {"1", %{"time_added" => @now |> Integer.to_string()}},
    {"1", %{"time_added" => @year_ago |> Integer.to_string()}},
    {"1", @item}
  ]

  test "archives an older items than a year" do
    items = PocketReducer.archive(@items)
    assert Enum.count(items) == 1
    assert items == [%{action: "archive", item_id: "740050382"}]
  end
end
