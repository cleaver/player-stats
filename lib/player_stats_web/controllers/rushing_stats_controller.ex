defmodule PlayerStatsWeb.RushingStatsController do
  use PlayerStatsWeb, :controller
  require Decimal
  alias PlayerStats.Stats
  alias PlayerStats.Util.CsvUtils

  @sort_cols [
    :longest,
    :yards,
    :touchdowns
  ]
  @safe_params ["sort", "filter", "page"]
  @limit 30
  @max_download_rows 9999

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

  def export(conn, params) do
    sort_params = parse_sort(params)
    filter = parse_filter(params)

    [page_count, rushing_stats] =
      Stats.list_rushing_stats_sorted(sort_params, filter, @max_download_rows, 0)

    if page_count > 0 do
      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", "attachment; filename=\"rushing_stats.csv\"")
      |> send_resp(200, CsvUtils.maplist_to_csv(rushing_stats))
    else
      render(conn, :"404")
    end
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
