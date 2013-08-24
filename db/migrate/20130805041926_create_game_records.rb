class CreateGameRecords < ActiveRecord::Migration
  def change
    create_table :game_records do |t|
      
      t.string :espn_id
      t.integer :player_id
      t.integer :game_id
      
      t.integer :opponent_id
      
      t.integer :minutes
      t.date :date
      
      t.integer :points
      t.integer :rebounds
      t.integer :assists
      
      t.integer :blocks
      t.integer :steals
      
      t.integer :turnovers

      t.timestamps
    end
  end
end
