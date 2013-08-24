class AddFinishedToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :finished, :boolean, :default => false
  end
end
