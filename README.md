# SideEffect

simple utils for making side effect calls and return the piped-in value in pipelines

## Installation

Add `side_effect` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:side_effect, "~> 0.1.0"}]
end
```

## Why

so instead of writing this:

```elixir
def three_transformations_with_a_side_effect(x) do
  temp =
    x
    |> transform1()
    |> transform2()

  notify_someone(temp)

  transform3(temp)
end
```

I'd just write:

```elixir
def three_transformations_with_a_side_effect(x) do
  x
  |> transform1()
  |> transform2()
  |> SideEffect.side_apply(&notify_someone/1)
  |> transform3()
end
```


## Usage

```
iex> 1 |> SideEffect.side_call(MyApp.send_notification()) |> List.wrap
[1]

iex> 1 |> SideEffect.side_apply(&MyApp.send_notification/1) |> List.wrap
[1]

iex> 1 |> SideEffect.side_apply(IO, :inspect) |> List.wrap
[1]

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
