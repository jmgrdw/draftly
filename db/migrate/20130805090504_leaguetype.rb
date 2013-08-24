class Leaguetype < ActiveRecord::Migration
  def change
    add_column :leagues, :league_type, :integer
  end
end
