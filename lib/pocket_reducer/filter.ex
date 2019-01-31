defmodule PocketReducer.Filter do
    @year 60 * 60 * 24 * 365
  
    def take_older_than_year(items) do
      ya = year_ago()
  
      Enum.filter(items, fn {_, %{"time_added" => time}} ->
        String.to_integer(time) < ya
      end)
    end
  
    defp year_ago(now \\ DateTime.utc_now()) do
      now
      |> DateTime.to_unix()
      |> Kernel.-(@year)
    end
  end
  