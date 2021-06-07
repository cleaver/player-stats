defmodule PlayerStatsWeb.RushingStatsView do
  use PlayerStatsWeb, :view
  import Phoenix.HTML.Link

  @doc """
  Compose a sorting link with query string.

  TODO: move sanitized `sort_params` back into `params` to save a function argument.
  """
  def sort_link(conn, text, column, title, params, sort_params \\ {}) do
    query_string =
      params |> Map.take(["filter"]) |> Map.merge(%{"sort" => "asc:" <> Atom.to_string(column)})

    link(text <> sort_symbol(column, sort_params),
      to: Routes.rushing_stats_path(conn, :index, query_string),
      title: title,
      class: nil
    )
  end

  def page_number(params, page_count) do
    page = parse_page(params)
    ~E(<span class="float-right">Page <%= page %> of <%= page_count %></span>)
  end

  def page_next(conn, text, params, page_count) do
    page = parse_page(params)

    if page < page_count do
      query_string = Map.merge(params, %{"page" => page + 1})

      link(text,
        to: Routes.rushing_stats_path(conn, :index, query_string),
        title: "Next page",
        class: "app-pager__link"
      )
    else
      ~E(<span class="app-pager__link--disabled"><%= text %></span>)
    end
  end

  def page_prev(conn, text, params, page_count) do
    page = parse_page(params)

    if page > 1 do
      query_string = Map.merge(params, %{"page" => page - 1})

      link(text,
        to: Routes.rushing_stats_path(conn, :index, query_string),
        title: "Previous page",
        class: "app-pager__link"
      )
    else
      ~E(<span class="app-pager__link--disabled"><%= text %></span>)
    end
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

  defp parse_page(params) do
    case params do
      %{"page" => page} -> String.to_integer(page)
      _ -> 1
    end
  end
end
