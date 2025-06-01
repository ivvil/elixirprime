defmodule Prime do
  def sieve([]), do: []

  def sieve([head | tail]) do
    if unmarked(head) do
      [head | sieve(mark_multiples(head, tail))]
    else
      sieve(tail)
    end
  end

  defp unmarked(n) when is_integer(n), do: true
  defp unmarked(false), do: false

  defp mark_multiples(_, []), do: []

  defp mark_multiples(p, [head | tail]) do
    if unmarked(head) && rem(head, p) == 0 do
      [false | mark_multiples(p, tail)]
    else
      [head | mark_multiples(p, tail)]
    end
  end

  def createlist(n) when n < 2, do: []
  def createlist(n), do: reverse(createlist_helper(2, n, []))

  defp createlist_helper(current, n, list) when current > n, do: list

  defp createlist_helper(current, n, list),
    do: createlist_helper(current + 1, n, [current | list])

  defp reverse(list), do: reverse(list, [])
  defp reverse([], acc), do: acc
  defp reverse([h | t], acc), do: reverse(t, [h | acc])

  def run(n) when n > 20, do: :halt

  def run(n) do
    n
    |> createlist()
    |> sieve()
    |> IO.inspect(label: "Primes up to #{n}")

    run(n + 1)
  end
end

Prime.run(2)
