defmodule Practice.Calc do
  def to_postfix([head | tail], op_stack, post_stack) do
    case head do
      {:num, x} -> to_postfix(tail, op_stack, post_stack ++ [x]) 
      {:op, x} -> 
        if (Enum.member?(op_stack, "*") || Enum.member?(op_stack, "*")) && (x == "+" || x == "-") do
          {popped, op_stack} = List.pop_at(op_stack, Enum.count(op_stack) - 1)  
          to_postfix(tail, op_stack ++ [x], post_stack ++ [popped])
        else
          to_postfix(tail, op_stack ++ [x], post_stack)
        end 
    end
  end

  def to_postfix([], [], post_stack) do
    post_stack
  end

  def to_postfix([], op_stack, post_stack) do
    if !Enum.empty?(op_stack) do
      {x, op_stack} = List.pop_at(op_stack, Enum.count(op_stack) - 1)  
      to_postfix([], op_stack, post_stack ++ [x])
    end
  end

  def evaluate([head | tail], stack) do
    case head do
      "*" -> evaluate(tail, Practice.Calc.pop_stack(stack) ++ Practice.Calc.multiply(stack))
      "/" -> evaluate(tail, Practice.Calc.pop_stack(stack) ++ Practice.Calc.divide(stack))
      "+" -> evaluate(tail, Practice.Calc.pop_stack(stack) ++ Practice.Calc.add(stack))
      "-" -> evaluate(tail, Practice.Calc.pop_stack(stack) ++ Practice.Calc.subtract(stack))
      _ -> evaluate(tail, stack ++ [head])
    end
  end

  def evaluate([], stack) do
    {x, _rest} = List.pop_at(stack, Enum.count(stack) - 1)
    x
  end

  def parse(string) do
    {intVal, ""} = Integer.parse(string)
    intVal
  end

  def pop_stack(stack) do
    elem(List.pop_at(elem(List.pop_at(stack, Enum.count(stack) - 1), 1), Enum.count(stack) - 2), 1)
  end

  def multiply(stack) do
    [Practice.Calc.get_first_value(stack) * Practice.Calc.get_second_value(stack)]
  end

  def divide(stack) do
    [Practice.Calc.get_first_value(stack) / Practice.Calc.get_second_value(stack)]
  end

  def add(stack) do
    [Practice.Calc.get_first_value(stack) + Practice.Calc.get_second_value(stack)]
  end

  def subtract(stack) do
    [Practice.Calc.get_first_value(stack) - Practice.Calc.get_second_value(stack)]
  end

  def get_first_value(stack) do
    elem(List.pop_at(stack, Enum.count(stack) - 2), 0)
  end

  def get_second_value(stack) do
    elem(List.pop_at(stack, Enum.count(stack) - 1), 0)
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> Enum.map(fn x -> case x do
      value when value in ["+", "*", "-", "/"] -> {:op, x}
      _ -> {:num, Practice.Calc.parse(x)}
      end
    end)
    |> Practice.Calc.to_postfix([], [])
    |> Practice.Calc.evaluate([])
  end
end
