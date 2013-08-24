class Addbooleantogamerecord < ActiveRecord::Migration
  def change
    add_column :game_records, :played, :boolean
  end
end
