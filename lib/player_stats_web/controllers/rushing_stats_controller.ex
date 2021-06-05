defmodule PlayerStatsWeb.RushingStatsController do
  use PlayerStatsWeb, :controller

  alias PlayerStats.Stats

  def index(conn, _params) do
    rushing_stats = Stats.list_rushing_stats()
    render(conn, "index.html", rushing_stats: rushing_stats)
  end

  def show(conn, %{"id" => id}) do
    rushing_stats = Stats.get_rushing_stats!(id)
    render(conn, "show.html", rushing_stats: rushing_stats)
  end
end
