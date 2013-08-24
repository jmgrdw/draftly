class CreateCurrentStats < ActiveRecord::Migration
  def change
    create_table :current_stats do |t|
      
      t.integer :player_id
      t.integer :game_id
      
      t.integer :minutes, :default => 0
      
      t.integer :points, :default => 0
      t.integer :rebounds, :default => 0
      t.integer :assists, :default => 0
      
      t.integer :blocks, :default => 0
      t.integer :steals, :default => 0
      
      t.integer :turnovers, :default => 0
      
      t.boolean :finished, :default => false

      t.timestamps
    end
  end
end
