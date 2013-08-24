class CreateGamesLeagues < ActiveRecord::Migration
  def change
    create_table :games_leagues do |t|
      t.integer :game_id
      t.integer :league_id

      t.timestamps
    end
  end
end
