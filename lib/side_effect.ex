defmodule SideEffect do
  @doc """
  iex> 1
  ...> |> SideEffect.side_call(2)
  1
  """
  def side_call(piped_value, _) do
    piped_value
  end

  @doc """
  iex> -1
  ...> |> SideEffect.side_apply(&abs/1)
  -1
  """
  def side_apply(piped_value, func) when is_function(func) do
    func.(piped_value)
    piped_value
  end

  @doc """
  iex> 1
  ...> |> SideEffect.side_apply(IO, :inspect)
  1

  iex> 1
  ...> |> SideEffect.side_apply(IO, :inspect, [[base: :hex]])
  ...> |> List.wrap
  [1]
  """
  def side_apply(piped_value, module, func, other_args \\ [], position \\ 0)
      when is_atom(module) and is_atom(func) and is_list(other_args) do
    Kernel.apply(module, func,
      Enum.take(other_args, position) ++
      [piped_value | Enum.drop(other_args, position)])
    piped_value
  end
end
