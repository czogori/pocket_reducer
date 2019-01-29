defmodule PocketReducer.Auth do
  @consumer_key Application.fetch_env!(:pocket_reducer, :api_key)
  @url Application.fetch_env!(:pocket_reducer, :url)
  @url_callback Application.fetch_env!(:pocket_reducer, :url_callback)
  @offset 1000

  def all(access_token, its \\ %{}, offset \\ 0) do
    client = Pocketeer.Client.new(@consumer_key, access_token)
    options = Pocketeer.Get.new(%{sort: :oldest, count: @offset, offset: offset, state: :unread})

    case Pocketeer.get(client, options) do
      {:ok, %{"list" => []}} -> its
      {:ok, %{"list" => items}} -> all(access_token, Map.merge(its, items), offset + @offset)
      _ -> :error
    end
  end

  def archive(access_token, items) do
    client = Pocketeer.Client.new(@consumer_key, access_token)
    Pocketeer.post(items, client)
  end

  def get_request_token() do
    {:ok, body} = Pocketeer.Auth.get_request_token(@consumer_key, @url)
    body["code"]
  end

  def get_authorize_url(request_token) do
    Pocketeer.Auth.authorize_url(request_token, @url_callback)
  end

  def get_access_token(request_token) do
    case Pocketeer.Auth.get_access_token(@consumer_key, request_token) do
      {:ok, body} -> body["access_token"]
      _ -> nil
    end
  end
end
