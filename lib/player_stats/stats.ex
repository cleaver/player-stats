defmodule PlayerStats.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias PlayerStats.Repo

  alias PlayerStats.Stats.RushingStats

  @doc """
  Returns the list of rushing_stats.

  ## Examples

      iex> list_rushing_stats()
      [%RushingStats{}, ...]

  """
  def list_rushing_stats do
    Repo.all(RushingStats)
  end

  @doc """
  Returns a sorted list of rushing_stats.

  ## Examples

  iex> list_rushing_stats_sorted({:asc, :player}, "joe")
  [%RushingStats{}, ...]

  """
  @spec list_rushing_stats_sorted(sort_params :: tuple(), name :: String.t()) :: any
  def list_rushing_stats_sorted(sort_params, name \\ "joe") do
    name_filter =
      if String.length(name) do
        dynamic([r], ilike(r.player, ^"%#{name}%"))
      else
        true
      end

    order = [sort_params]

    query =
      RushingStats
      |> where(^name_filter)
      |> order_by(^order)

    Repo.all(query)
  end

  @doc """
  Gets a single rushing_stats.

  Raises `Ecto.NoResultsError` if the Rushing stats does not exist.

  ## Examples

      iex> get_rushing_stats!(123)
      %RushingStats{}

      iex> get_rushing_stats!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rushing_stats!(id), do: Repo.get!(RushingStats, id)

  @doc """
  Creates a rushing_stats.

  ## Examples

      iex> create_rushing_stats(%{field: value})
      {:ok, %RushingStats{}}

      iex> create_rushing_stats(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rushing_stats(attrs \\ %{}) do
    %RushingStats{}
    |> RushingStats.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rushing_stats.

  ## Examples

      iex> update_rushing_stats(rushing_stats, %{field: new_value})
      {:ok, %RushingStats{}}

      iex> update_rushing_stats(rushing_stats, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rushing_stats(%RushingStats{} = rushing_stats, attrs) do
    rushing_stats
    |> RushingStats.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rushing_stats.

  ## Examples

      iex> delete_rushing_stats(rushing_stats)
      {:ok, %RushingStats{}}

      iex> delete_rushing_stats(rushing_stats)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rushing_stats(%RushingStats{} = rushing_stats) do
    Repo.delete(rushing_stats)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rushing_stats changes.

  ## Examples

      iex> change_rushing_stats(rushing_stats)
      %Ecto.Changeset{data: %RushingStats{}}

  """
  def change_rushing_stats(%RushingStats{} = rushing_stats, attrs \\ %{}) do
    RushingStats.changeset(rushing_stats, attrs)
  end
end
