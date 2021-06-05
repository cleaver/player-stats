defmodule PlayerStatsWeb.RushingStatsControllerTest do
  use PlayerStatsWeb.ConnCase

  alias PlayerStats.Stats

  @create_attrs %{
    attempts: 42,
    attempts_game: "120.5",
    first_down_pc: "120.5",
    first_downs: 42,
    fumbles: 42,
    longest: 42,
    longest_td: true,
    player: "some player",
    position: "some position",
    team: "some team",
    touchdowns: 42,
    yards: 42,
    yards_20: 42,
    yards_40: 42,
    yards_avg: "120.5",
    yards_game: "120.5"
  }
  @update_attrs %{
    attempts: 43,
    attempts_game: "456.7",
    first_down_pc: "456.7",
    first_downs: 43,
    fumbles: 43,
    longest: 43,
    longest_td: false,
    player: "some updated player",
    position: "some updated position",
    team: "some updated team",
    touchdowns: 43,
    yards: 43,
    yards_20: 43,
    yards_40: 43,
    yards_avg: "456.7",
    yards_game: "456.7"
  }
  @invalid_attrs %{
    attempts: nil,
    attempts_game: nil,
    first_down_pc: nil,
    first_downs: nil,
    fumbles: nil,
    longest: nil,
    longest_td: nil,
    player: nil,
    position: nil,
    team: nil,
    touchdowns: nil,
    yards: nil,
    yards_20: nil,
    yards_40: nil,
    yards_avg: nil,
    yards_game: nil
  }

  def fixture(:rushing_stats) do
    {:ok, rushing_stats} = Stats.create_rushing_stats(@create_attrs)
    rushing_stats
  end

  describe "index" do
    test "lists all rushing_stats", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rushing stats"
    end
  end

  describe "show" do
    setup [:create_rushing_stats]

    test "renders individual stat", %{conn: conn, rushing_stats: rushing_stats} do
      id = rushing_stats.id
      conn = get(conn, Routes.rushing_stats_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rushing stats"
    end
  end

  defp create_rushing_stats(_) do
    rushing_stats = fixture(:rushing_stats)
    %{rushing_stats: rushing_stats}
  end
end
