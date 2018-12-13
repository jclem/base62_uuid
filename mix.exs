defmodule Base62UUID.Mixfile do
  use Mix.Project

  @version "2.0.2"
  @github_url "https://github.com/jclem/base62_uuid"

  def project do
    [
      app: :base62_uuid,
      description: "A library for creating Base62-encoded UUIDs",
      version: @version,
      package: package(),
      name: "Base62UUID",
      homepage_url: @github_url,
      source_url: @github_url,
      docs: docs(),
      elixir: "~> 1.3",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.html": :test,
        "coveralls.json": :test,
        "coveralls.post": :test,
        "coveralls.travis": :test
      ],
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    []
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:base62, "~> 1.2.0"},
      {:uuid, "~> 1.1.5"},
      {:ex_doc, "~> 0.19.1", only: [:dev]},
      {:excoveralls, "~> 0.10.3", only: [:test]}
    ]
  end

  defp package do
    [
      name: :base62_uuid,
      licenses: ["MIT"],
      maintainers: ["Jonathan Clem <jonathan@jclem.net>"],
      links: %{"GitHub" => @github_url}
    ]
  end

  defp docs do
    [extras: ~w(README.md LICENSE.md), main: "readme", source_ref: "v#{@version}"]
  end
end
