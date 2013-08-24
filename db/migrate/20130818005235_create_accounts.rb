class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :balance, :default => 0

      t.timestamps
    end
  end
end
