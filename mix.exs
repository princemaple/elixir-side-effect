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

  def application do
    [applications: [:logger]]
  end

  defp description do
    "simple utils for making side effect calls in pipelines"
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
