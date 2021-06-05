defmodule PlayerStats.StatsTest do
  use PlayerStats.DataCase

  alias PlayerStats.Stats

  describe "rushing_stats" do
    alias PlayerStats.Stats.RushingStats

    @valid_attrs %{attempts: 42, attempts_game: "120.5", first_down_pc: "120.5", first_downs: 42, fumbles: 42, longest: 42, longest_td: true, player: "some player", position: "some position", team: "some team", touchdowns: 42, yards: 42, yards_20: 42, yards_40: 42, yards_avg: "120.5", yards_game: "120.5"}
    @update_attrs %{attempts: 43, attempts_game: "456.7", first_down_pc: "456.7", first_downs: 43, fumbles: 43, longest: 43, longest_td: false, player: "some updated player", position: "some updated position", team: "some updated team", touchdowns: 43, yards: 43, yards_20: 43, yards_40: 43, yards_avg: "456.7", yards_game: "456.7"}
    @invalid_attrs %{attempts: nil, attempts_game: nil, first_down_pc: nil, first_downs: nil, fumbles: nil, longest: nil, longest_td: nil, player: nil, position: nil, team: nil, touchdowns: nil, yards: nil, yards_20: nil, yards_40: nil, yards_avg: nil, yards_game: nil}

    def rushing_stats_fixture(attrs \\ %{}) do
      {:ok, rushing_stats} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stats.create_rushing_stats()

      rushing_stats
    end

    test "list_rushing_stats/0 returns all rushing_stats" do
      rushing_stats = rushing_stats_fixture()
      assert Stats.list_rushing_stats() == [rushing_stats]
    end

    test "get_rushing_stats!/1 returns the rushing_stats with given id" do
      rushing_stats = rushing_stats_fixture()
      assert Stats.get_rushing_stats!(rushing_stats.id) == rushing_stats
    end

    test "create_rushing_stats/1 with valid data creates a rushing_stats" do
      assert {:ok, %RushingStats{} = rushing_stats} = Stats.create_rushing_stats(@valid_attrs)
      assert rushing_stats.attempts == 42
      assert rushing_stats.attempts_game == Decimal.new("120.5")
      assert rushing_stats.first_down_pc == Decimal.new("120.5")
      assert rushing_stats.first_downs == 42
      assert rushing_stats.fumbles == 42
      assert rushing_stats.longest == 42
      assert rushing_stats.longest_td == true
      assert rushing_stats.player == "some player"
      assert rushing_stats.position == "some position"
      assert rushing_stats.team == "some team"
      assert rushing_stats.touchdowns == 42
      assert rushing_stats.yards == 42
      assert rushing_stats.yards_20 == 42
      assert rushing_stats.yards_40 == 42
      assert rushing_stats.yards_avg == Decimal.new("120.5")
      assert rushing_stats.yards_game == Decimal.new("120.5")
    end

    test "create_rushing_stats/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_rushing_stats(@invalid_attrs)
    end

    test "update_rushing_stats/2 with valid data updates the rushing_stats" do
      rushing_stats = rushing_stats_fixture()
      assert {:ok, %RushingStats{} = rushing_stats} = Stats.update_rushing_stats(rushing_stats, @update_attrs)
      assert rushing_stats.attempts == 43
      assert rushing_stats.attempts_game == Decimal.new("456.7")
      assert rushing_stats.first_down_pc == Decimal.new("456.7")
      assert rushing_stats.first_downs == 43
      assert rushing_stats.fumbles == 43
      assert rushing_stats.longest == 43
      assert rushing_stats.longest_td == false
      assert rushing_stats.player == "some updated player"
      assert rushing_stats.position == "some updated position"
      assert rushing_stats.team == "some updated team"
      assert rushing_stats.touchdowns == 43
      assert rushing_stats.yards == 43
      assert rushing_stats.yards_20 == 43
      assert rushing_stats.yards_40 == 43
      assert rushing_stats.yards_avg == Decimal.new("456.7")
      assert rushing_stats.yards_game == Decimal.new("456.7")
    end

    test "update_rushing_stats/2 with invalid data returns error changeset" do
      rushing_stats = rushing_stats_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_rushing_stats(rushing_stats, @invalid_attrs)
      assert rushing_stats == Stats.get_rushing_stats!(rushing_stats.id)
    end

    test "delete_rushing_stats/1 deletes the rushing_stats" do
      rushing_stats = rushing_stats_fixture()
      assert {:ok, %RushingStats{}} = Stats.delete_rushing_stats(rushing_stats)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_rushing_stats!(rushing_stats.id) end
    end

    test "change_rushing_stats/1 returns a rushing_stats changeset" do
      rushing_stats = rushing_stats_fixture()
      assert %Ecto.Changeset{} = Stats.change_rushing_stats(rushing_stats)
    end
  end
end
