class AddStartedToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :started, :boolean, :default => false
  end
end
