defmodule PlayerStats.Util.DataParsing do
  @moduledoc """
  Utility functions for parsing data for import.

  """

  @doc """
  Parse a integer that may be in string form.

  iex> PlayerStats.Util.DataParsing.safe_int(123)
  123

  iex> PlayerStats.Util.DataParsing.safe_int("-1,234")
  -1234

  """
  @spec safe_int(String.t() | integer) :: integer
  def safe_int(value) when is_integer(value), do: value

  def safe_int(value) do
    {int_value, _} = String.replace(value, ",", "") |> Integer.parse()
    int_value
  end

  @doc """
  Parse a float or integer and return a decimal value.

  ## Examples

  iex> PlayerStats.Util.DataParsing.float_to_decimal(23)
  #Decimal<23>

  iex> PlayerStats.Util.DataParsing.float_to_decimal(23.4)
  #Decimal<23.4>

  """
  @spec float_to_decimal(number) :: Decimal.t()
  def float_to_decimal(value) when is_float(value), do: Float.to_string(value) |> Decimal.new()

  def float_to_decimal(value) when is_integer(value),
    do: Integer.to_string(value) |> Decimal.new()

  @doc """
  Parse string or integer to determine if it records a touchdown.

  ## Examples

  iex> PlayerStats.Util.DataParsing.is_touchdown(25)
  false

  iex> PlayerStats.Util.DataParsing.is_touchdown("25T")
  true

  """
  @spec is_touchdown(String.t() | integer) :: boolean
  def is_touchdown(value) when is_integer(value), do: false

  def is_touchdown(value), do: String.last(value) == "T"
end
