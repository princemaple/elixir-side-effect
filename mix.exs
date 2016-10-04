defmodule SideEffect.Mixfile do
  use Mix.Project

  def project do
    [app: :side_effect,
     description: description(),
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     package: package()]
  end

  defp package do
    [name: :side_effect,
     files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Po Chen"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/princemaple/elixir-side-effect"}]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    "simple utils for making side effect calls in pipelines"
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
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
