defmodule SideEffectTest do
  use ExUnit.Case
  doctest SideEffect

  defp echo_server do
    receive do
      {from, any} ->
        send from, any
    end
    echo_server
  end

  setup_all _context do
    [echo: spawn(&echo_server/0)]
  end

  test "it makes a call as a side effect", %{echo: echo} do
    assert SideEffect.side_call(1, send(echo, {self(), :sent})) == 1
    assert_receive :sent
  end

  test "it applies the function as a side effect", %{echo: echo} do
    assert SideEffect.side_apply(1, &send(echo, {self(), &1})) == 1
    assert_receive 1
  end

  def test(echo, a, b, c) do
    send echo, {self(), [a, b, c]}
  end

  test "it applies the module function as a side effect", %{echo: echo} do
    assert SideEffect.side_apply(1, SideEffectTest, :test, [echo, 2, 3], 1) == 1
    assert_receive [1, 2, 3]
  end
end
