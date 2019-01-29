defmodule PocketReducerWeb.PageView do
  use PocketReducerWeb, :view

  def get_date(timestamp) when is_bitstring(timestamp) do
    case DateTime.from_unix(String.to_integer(timestamp)) do
      {:ok, date_time} -> DateTime.to_date(date_time)
      _ -> "Unknown date " <> timestamp
    end
  end
end
