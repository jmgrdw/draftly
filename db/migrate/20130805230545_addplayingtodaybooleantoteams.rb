class Addplayingtodaybooleantoteams < ActiveRecord::Migration
  def change
    add_column :teams, :playing_today, :boolean
  end
end
