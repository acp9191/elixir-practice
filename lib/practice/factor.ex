defmodule Practice.Factor do
  def factor_num(x, accumulator, i) do
    if rem(x, i) == 0 do
      factor_num(trunc(x / i), [i] ++ accumulator, i)
    else 
      {x, accumulator}
    end
  end

  def factor_odds({x, accumulator}, i) do
    if x >= i do
      if rem(x, i) == 0 do
        factor_odds(factor_num(x, accumulator, i), i + 2)
      else
        factor_odds({x, accumulator}, i + 2)
      end
    else
      accumulator
    end
  end

  def factor(expr) do
    expr
    |> Practice.Factor.factor_num([], 2)
    |> Practice.Factor.factor_odds(3)
    |> Enum.reverse()
  end
end
