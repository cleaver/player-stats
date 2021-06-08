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
    touchdowns: 20,
    yards: 10,
    yards_20: 42,
    yards_40: 42,
    yards_avg: "120.5",
    yards_game: "120.5"
  }
  @more_attrs %{
    attempts: 43,
    attempts_game: "456.7",
    first_down_pc: "456.7",
    first_downs: 43,
    fumbles: 43,
    longest: 43,
    longest_td: false,
    player: "another player",
    position: "another position",
    team: "another team",
    touchdowns: 10,
    yards: 20,
    yards_20: 43,
    yards_40: 43,
    yards_avg: "456.7",
    yards_game: "456.7"
  }

  def fixture(:rushing_stats) do
    {:ok, rushing_stats} = Stats.create_rushing_stats(@create_attrs)
    Stats.create_rushing_stats(@more_attrs)
    rushing_stats
  end

  describe "index" do
    setup [:create_rushing_stats]

    test "lists rushing_stats", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :index))
      assert html_response(conn, 200) =~ "some player"
    end

    test "filters out rushing_stats", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :index, filter: "asdfasdf"))
      refute html_response(conn, 200) =~ "some player"
    end

    test "sorts rushing_stats", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :index, sort: "asc:yards"))
      assert html_response(conn, 200) =~ ~r/some player.+another player/s
      conn = get(conn, Routes.rushing_stats_path(conn, :index, sort: "asc:touchdowns"))
      assert html_response(conn, 200) =~ ~r/another player.+some player/s
    end
  end

  describe "export" do
    setup [:create_rushing_stats]

    test "exports csv", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :export))
      assert response_content_type(conn, :csv) =~ "charset=utf-8"
    end

    test "exports rushing_stats", %{conn: conn} do
      conn = get(conn, Routes.rushing_stats_path(conn, :export))
      assert response(conn, 200) =~ "some player"
    end
  end

  defp create_rushing_stats(_) do
    rushing_stats = fixture(:rushing_stats)
    %{rushing_stats: rushing_stats}
  end
end
