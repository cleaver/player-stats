defmodule Mix.Tasks.LoadRushing do
  use Mix.Task
  alias PlayerStats.Repo
  alias PlayerStats.Stats.RushingStats
  import PlayerStats.Util.DataParsing

  @shortdoc "Load Rushing Stats"

  @moduledoc """
  Warning: will wipe and replace table.
  """

  def run(args) do
    Mix.Task.run("app.start")
    contents = File.read!(args)
    records = Jason.decode!(contents)
    Repo.delete_all(RushingStats)
    Enum.each(records, fn record -> insert_row(record) end)
  end

  def insert_row(record) do
    record |> transform_record |> Repo.insert()
  end

  def transform_record(record) do
    %RushingStats{
      player: record["Player"],
      team: record["Team"],
      position: record["Pos"],
      attempts: safe_int(record["Att"]),
      attempts_game: float_to_decimal(record["Att/G"]),
      yards: safe_int(record["Yds"]),
      yards_avg: float_to_decimal(record["Avg"]),
      yards_game: float_to_decimal(record["Yds/G"]),
      touchdowns: safe_int(record["TD"]),
      longest: safe_int(record["Lng"]),
      longest_td: is_touchdown(record["Lng"]),
      first_downs: safe_int(record["1st"]),
      first_down_pc: float_to_decimal(record["1st%"]),
      yards_20: safe_int(record["20+"]),
      yards_40: safe_int(record["40+"]),
      fumbles: safe_int(record["FUM"])
    }
  end
end
