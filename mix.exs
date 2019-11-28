defmodule Tzdata.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [
      app: :tzdata,
      name: "tzdata",
      version: @version,
      elixir: "~> 1.8",
      package: package(),
      description: description(),
      deps: deps(),
      docs: docs(),
      source_url: "https://github.com/lau/tzdata"
    ]
  end

  def application do
    [
      applications: applications(Mix.env()),
      extra_applications: [:logger],
      env: env(),
      mod: {Tzdata.App, []}
    ]
  end

  defp applications(_), do: []

  defp deps do
    [
      {:tesla, "~> 1.3.0"},
      {:castore, "~> 0.1.0", optional: true},
      {:mint, "~> 1.0", override: true, optional: true},
      {:hackney, "~> 1.0", optional: true},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"],
      source_ref: "v#{@version}"
    ]
  end

  defp env do
    [
      autoupdate: :enabled,
      data_dir: nil,
      http_client: Tzdata.HTTPClient.Tesla
    ]
  end

  defp description do
    """
    Tzdata is a parser and library for the tz database.
    """
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Lau Taarnskov"],
      links: %{"GitHub" => "https://github.com/lau/tzdata"},
      files: ~w(lib priv mix.exs README* LICENSE*
                 CHANGELOG*)
    }
  end
end
