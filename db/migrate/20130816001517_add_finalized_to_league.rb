class AddFinalizedToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :finalized, :boolean, :default => false
  end
end
