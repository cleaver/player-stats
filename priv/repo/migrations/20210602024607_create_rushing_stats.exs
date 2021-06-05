defmodule PlayerStats.Repo.Migrations.CreateRushingStats do
  use Ecto.Migration

  def change do
    create table(:rushing_stats) do
      add :player, :string
      add :team, :string
      add :position, :string
      add :attempts, :integer
      add :attempts_game, :decimal
      add :yards, :integer
      add :yards_avg, :decimal
      add :yards_game, :decimal
      add :touchdowns, :integer
      add :longest, :integer
      add :longest_td, :boolean, default: false, null: false
      add :first_downs, :integer
      add :first_down_pc, :decimal
      add :yards_20, :integer
      add :yards_40, :integer
      add :fumbles, :integer

      timestamps()
    end

  end
end
