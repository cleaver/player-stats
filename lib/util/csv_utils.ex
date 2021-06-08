defmodule PlayerStats.Util.CsvUtils do
  @moduledoc """
  Utility for transforming list of maps to CSV strings.
  """
  require Decimal

  @doc """
  Transform list of maps to a CSV string.

  Note that columns are sorted by key value. See example.

  Assumption: `true` should be transformed to `"T"` and `false` to `""`
  to handle special case for touchdowns.

  ## Examples

  iex> PlayerStats.Util.CsvUtils.maplist_to_csv([%{foo: 1, bar: "baz"}])
  ~s("bar","foo"\n"baz",1)

  """
  def maplist_to_csv(data_list) when is_list(data_list) do
    header_row =
      hd(data_list)
      |> Map.drop([:__meta__, :__struct__, :id])
      |> Map.keys()
      |> Enum.map(fn key -> "\"#{to_string(key)}\"" end)
      |> Enum.join(",")

    body_rows =
      data_list
      |> Enum.map(fn key -> transform_row(key) end)

    Enum.join([header_row | body_rows], "\n")
  end

  def maplist_to_csv(_), do: ""

  @doc """
  Transform a map to string a single string containing the values.

  Note that values are sorted by key order.

  ## Example:

  iex> PlayerStats.Util.CsvUtils.transform_row(%{foo: 1, bar: "baz"})
  ~s("baz",1)

  """
  def transform_row(row) do
    row
    |> Map.drop([:__meta__, :__struct__, :id])
    |> Map.values()
    |> Enum.map(fn value -> transform_value(value) end)
    |> Enum.join(",")
  end

  @doc """
  Transform an individual data value. Surround with quotes where necessary.

  ## Examples

  iex> PlayerStats.Util.CsvUtils.transform_value(123)
  "123"

  iex> PlayerStats.Util.CsvUtils.transform_value(1.23)
  "1.23"

  iex> PlayerStats.Util.CsvUtils.transform_value(Decimal.new("12.3"))
  "12.3"

  iex> PlayerStats.Util.CsvUtils.transform_value("foo")
  ~s("foo")

  iex> PlayerStats.Util.CsvUtils.transform_value(true)
  ~s("T")

  iex> PlayerStats.Util.CsvUtils.transform_value(false)
  ""


  """
  def transform_value(value) when is_number(value), do: to_string(value)
  def transform_value(true), do: ~s("T")
  def transform_value(false), do: ""
  def transform_value(value) when is_binary(value), do: "\"#{value}\""

  def transform_value(value) do
    if Decimal.is_decimal(value) do
      Decimal.to_string(value)
    else
      ""
    end
  end
end
