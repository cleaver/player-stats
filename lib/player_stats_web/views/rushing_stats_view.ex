defmodule PlayerStatsWeb.RushingStatsView do
  use PlayerStatsWeb, :view
  import Phoenix.HTML.Link

  def sort_link(conn, text, column, title, sort_params \\ {}) do
    link(text <> sort_symbol(column, sort_params),
      to: Routes.rushing_stats_path(conn, :index, sort: "asc:" <> Atom.to_string(column)),
      title: title,
      class: nil
    )
  end

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
