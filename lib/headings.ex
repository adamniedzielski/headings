defmodule Headings do
  def main(_args) do
    raw = IO.read(:stdio, :all)
    [meta, blocks] = Poison.Parser.parse!(raw)
    result = [meta, Enum.map(blocks, &transform_heading/1)]
    IO.puts Poison.Encoder.encode(result, [])
  end

  defp transform_heading(%{
    "t" => "Header",
    "c" => [level, [identifier, classes, opts], content]
  }) when level > 1 do
    %{
      "t" => "Header",
      "c" => [
        level,
        [identifier, classes ++ ["unnumbered"], opts],
        content
      ]
    }
  end
  defp transform_heading(block), do: block
end
