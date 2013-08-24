class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :full_name
      t.string :espn_url
      t.integer :team_id
      t.string :position

      t.timestamps
    end
  end
end
