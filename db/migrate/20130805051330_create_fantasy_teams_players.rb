class CreateFantasyTeamsPlayers < ActiveRecord::Migration
  def change
    create_table :fantasy_teams_players do |t|
      t.integer :player_id
      t.integer :fantasy_team_id

      t.timestamps
    end
  end
end
