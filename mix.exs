defmodule Doorboy.MixProject do
  use Mix.Project

  @description """
  Simple and Light-Weight Library for Authorization made with Elixir
  """

  def project do
    [
      app: :doorboy,
      version: "0.1.1",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "Doorman",
      description: @description,
      package: package,
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package do
    [
      maintainers: ["mori"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/mori5321/doorman" }
    ]
  end
end
