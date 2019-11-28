defmodule Tzdata.HTTPClient.Hackney do
  @moduledoc false

  @behaviour Tzdata.HTTPClient

  if Code.ensure_loaded?(:hackney) do
    @impl true
    def get(url, headers, options) do
      with {:ok, status, headers, client_ref} <- :hackney.get(url, headers, "", options),
           {:ok, body} <- :hackney.body(client_ref) do
        {:ok, {status, headers, body}}
      end
    end

    @impl true
    def head(url, headers, options) do
      with {:ok, status, headers} <- :hackney.head(url, headers, "", options) do
        {:ok, {status, headers}}
      end
    end
  end
end
