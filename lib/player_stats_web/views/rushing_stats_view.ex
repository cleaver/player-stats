defmodule PlayerStatsWeb.RushingStatsView do
  use PlayerStatsWeb, :view
  import Phoenix.HTML.Link

  @doc """
  Compose a sorting link with query string.

  TODO: move sanitized `sort_params` back into `params` to save a function argument.
  """
  def sort_link(conn, text, column, title, params, sort_params \\ {}) do
    query_string = Map.merge(params, %{"sort" => "asc:" <> Atom.to_string(column)})

    link(text <> sort_symbol(column, sort_params),
      to: Routes.rushing_stats_path(conn, :index, query_string),
      title: title,
      class: nil
    )
  end

  @doc """
  Add an indicator character if column is sorted.

  TODO: This would be more flexible as a CSS class.
  """
  def sort_symbol(column, sort_params) do
    case sort_params do
      {:asc, ^column} ->
        "⇧"

      {:desc, ^column} ->
        "⇩"

      _ ->
        ""
    end
  end
end
