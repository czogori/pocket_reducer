defmodule PocketReducer.Api do
    alias PocketReducer.Auth

    @offset 1000
  
    def all(access_token, its \\ %{}, offset \\ 0) do
      client = Auth.get_client(access_token)
      options = Pocketeer.Get.new(%{sort: :oldest, count: @offset, offset: offset, state: :unread})
  
      case Pocketeer.get(client, options) do
        {:ok, %{"list" => []}} -> its
        {:ok, %{"list" => items}} -> all(access_token, Map.merge(its, items), offset + @offset)
        _ -> :error
      end
    end
  
    def archive(access_token, items) do
      client = Auth.get_client(access_token)
      Pocketeer.post(items, client)
    end
  end
  