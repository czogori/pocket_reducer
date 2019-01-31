defmodule PocketReducer.ReducerTest do
  use ExUnit.Case

  alias PocketReducer.Filter

  @now DateTime.utc_now() |> DateTime.to_unix()
  @year 60 * 60 * 24 * 365
  @year_ago @now - @year
  @more_than_year_ago @year_ago - 1

  @items [
    {"1", %{"time_added" => @now |> Integer.to_string()}},
    {"1", %{"time_added" => @year_ago |> Integer.to_string()}},
    {"1", %{"time_added" => @more_than_year_ago |> Integer.to_string()}}
  ]

  test "takes an older items than a year" do
    items = Filter.take_older_than_year(@items)
    assert Enum.count(items) == 1
  end
end
