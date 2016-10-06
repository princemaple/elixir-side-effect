# SideEffect

simple utils for making side effect calls and return the piped-in value in pipelines

## Installation

Add `side_effect` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:side_effect, "~> 0.1.0"}]
end
```


## Usage

```
iex> 1 |> SideEffect.side_call(MyApp.send_notification())
1
"""

iex> 1 |> SideEffect.side_apply(&MyApp.send_notification/1)
1

iex> 1 |> SideEffect.side_apply(IO, :inspect)
1

iex> 1 |> SideEffect.side_apply(IO, :inspect, [[base: :hex]]) |> List.wrap
[1]
```

```elixir
defmodule M do
  def test(a, b, c, d), do: IO.inspect([a, b, c, d])
end

b = 2

SideFeect.side_apply(b, M, :test, [1, 3, 4], 1)

# prints [1,2,3,4]
# returns 2
```
