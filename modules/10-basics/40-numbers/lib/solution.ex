defmodule Solution do
  # BEGIN
  def do_math(a, b) do
    IO.puts((a + b) / b)
    IO.puts(div(a, b))
    IO.puts(rem(b, a))
  end

  # END
end
