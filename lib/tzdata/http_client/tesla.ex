defmodule Tzdata.HTTPClient.Tesla do
  @moduledoc false

  @behaviour Tzdata.HTTPClient

  if Code.ensure_loaded?(Tesla) do
    @impl true
    def get(url, headers, _options) do
      with {:ok, %{status: status, headers: headers, body: body}} <-
             client() |> Tesla.get(url, headers: headers) do
        {:ok, {status, headers, body}}
      end
    end

    @impl true
    def head(url, headers, _options) do
      with {:ok, %{status: status, headers: headers}} <-
             client() |> Tesla.head(url, headers: headers) do
        {:ok, {status, headers}}
      end
    end

    defp client do
      Tesla.client(
        [Tesla.Middleware.FollowRedirects, Tesla.Middleware.Logger],
        Tesla.Adapter.Mint
      )
    end
  end
end
