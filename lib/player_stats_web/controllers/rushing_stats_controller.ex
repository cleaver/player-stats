defmodule PlayerStatsWeb.RushingStatsController do
  use PlayerStatsWeb, :controller

  alias PlayerStats.Stats

  @sort_cols [
    :longest,
    :yards,
    :touchdowns
  ]

  @safe_params ["sort", "filter", "page"]

  @limit 30

  @doc """
  Respond to request for rushing stats list.

  TODO:
  """
  def index(conn, params) do
    params = Map.take(params, @safe_params)
    sort_params = parse_sort(params)
    filter = parse_filter(params)
    offset = parse_offset(params, @limit)

    [page_count, rushing_stats] =
      Stats.list_rushing_stats_sorted(sort_params, filter, @limit, offset)

    render(conn, "index.html",
      rushing_stats: rushing_stats,
      sort_params: sort_params,
      params: params,
      page_count: page_count
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

  def parse_filter(%{"filter" => filter}), do: filter
  def parse_filter(_), do: ""

  def parse_offset(%{"page" => "0"}, _), do: 0

  def parse_offset(%{"page" => page}, limit),
    do: (Kernel.abs(String.to_integer(page)) - 1) * limit

  def parse_offset(_, _), do: 0
end
