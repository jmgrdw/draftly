class CreateTransactionHistories < ActiveRecord::Migration
  def change
    create_table :transaction_histories do |t|
      t.integer :value
      t.integer :fantasy_team_id
      t.integer :account_id

      t.timestamps
    end
  end
end
