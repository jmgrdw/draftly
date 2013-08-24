class Addleagueidtofteams < ActiveRecord::Migration
  def change
    add_column :fantasy_teams, :league_id, :integer
  end
end
