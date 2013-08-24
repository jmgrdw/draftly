class Addtypetofantasyteam < ActiveRecord::Migration
  def change
    add_column :fantasy_teams, :type, :string
  end
end
