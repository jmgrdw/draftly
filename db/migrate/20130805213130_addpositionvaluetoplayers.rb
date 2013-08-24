class Addpositionvaluetoplayers < ActiveRecord::Migration
  def change
    add_column :players, :position_value, :integer
  end
end
