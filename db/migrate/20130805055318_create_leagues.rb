class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.integer :size
      t.integer :fee
      t.datetime :start_date
      t.integer :salary_cap

      t.timestamps
    end
  end
end
