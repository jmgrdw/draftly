class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :amount
      t.string :title

      t.timestamps
    end
  end
end
