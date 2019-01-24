defmodule Practice.IsPalindrome do

  def make_reversed_copy(string) do
    {String.codepoints(string), String.codepoints(String.reverse(string))}
  end

  def interleave({char_list_1, char_list_2}, acc) do
    if Enum.empty?(char_list_1) do
      acc
    else 
      interleave({tl(char_list_1), tl(char_list_2)}, [hd(char_list_1)] ++ [hd(char_list_2)] ++ acc)
    end
  end

  def checkDoubleList(list) do
    if list == [] do
      true
    else
      if hd(list) == hd(tl(list)) do
        checkDoubleList(tl(tl(list)))
      else
        false
      end
    end
  end

  def is_palindrome(string) do
    string
    |> Practice.IsPalindrome.make_reversed_copy()
    |> Practice.IsPalindrome.interleave([])
    |> Practice.IsPalindrome.checkDoubleList()
  end
end
