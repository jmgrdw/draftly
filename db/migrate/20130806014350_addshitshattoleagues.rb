class Addshitshattoleagues < ActiveRecord::Migration
  def change
    add_column :leagues, :min_size, :integer
    add_column :leagues, :unique_payout_positions, :integer
  end
end
