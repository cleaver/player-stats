defmodule PlayerStats.Stats.RushingStats do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rushing_stats" do
    field :attempts, :integer
    field :attempts_game, :decimal
    field :first_down_pc, :decimal
    field :first_downs, :integer
    field :fumbles, :integer
    field :longest, :integer
    field :longest_td, :boolean, default: false
    field :player, :string
    field :position, :string
    field :team, :string
    field :touchdowns, :integer
    field :yards, :integer
    field :yards_20, :integer
    field :yards_40, :integer
    field :yards_avg, :decimal
    field :yards_game, :decimal

    timestamps()
  end

  @doc false
  def changeset(rushing_stats, attrs) do
    rushing_stats
    |> cast(attrs, [
      :player,
      :team,
      :position,
      :attempts,
      :attempts_game,
      :yards,
      :yards_avg,
      :yards_game,
      :touchdowns,
      :longest,
      :longest_td,
      :first_downs,
      :first_down_pc,
      :yards_20,
      :yards_40,
      :fumbles
    ])
    |> validate_required([
      :player,
      :team,
      :position,
      :attempts,
      :attempts_game,
      :yards,
      :yards_avg,
      :yards_game,
      :touchdowns,
      :longest,
      :longest_td,
      :first_downs,
      :first_down_pc,
      :yards_20,
      :yards_40,
      :fumbles
    ])
  end
end
