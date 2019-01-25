defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = inspect(Practice.calc(expr))
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.factor(x)
    y = inspect(y)
    render conn, "factor.html", x: x, y: y
  end

  def is_palindrome(conn, %{"string" => string}) do
    y = Practice.is_palindrome(string)
    render conn, "is_palindrome.html", string: string, y: y
  end
end
