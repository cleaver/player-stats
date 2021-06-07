defmodule PlayerStatsWeb.RushingStatsController do
  use PlayerStatsWeb, :controller

  alias PlayerStats.Stats

  @sort_cols [
    :longest,
    :yards,
    :touchdowns
  ]

  @safe_params ["sort", "filter", "page"]

  def index(conn, params) do
    params = Map.take(params, @safe_params)
    sort_params = parse_sort(params)

    filter =
      case params do
        %{"filter" => filter} -> filter
        _ -> ""
      end

    rushing_stats = Stats.list_rushing_stats_sorted(sort_params, filter)

    render(conn, "index.html",
      rushing_stats: rushing_stats,
      sort_params: sort_params,
      params: params
    )
  end

  def show(conn, %{"id" => id}) do
    rushing_stats = Stats.get_rushing_stats!(id)
    render(conn, "show.html", rushing_stats: rushing_stats)
  end

  def parse_sort(%{"sort" => sort_column}) do
    sort_column
    |> String.split(":", parts: 2)
    |> valid_sort()
  end

  def parse_sort(_), do: nil

  def valid_sort([direction, column]) do
    dir_atom = String.to_atom(direction)
    col_atom = String.to_atom(column)

    if dir_atom in [:asc, :desc] &&
         col_atom in @sort_cols do
      {dir_atom, col_atom}
    end
  end

  def valid_sort(_), do: nil
end
