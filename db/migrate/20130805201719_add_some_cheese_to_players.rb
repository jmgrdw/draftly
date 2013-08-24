class AddSomeCheeseToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :salary, :integer
  end
end
