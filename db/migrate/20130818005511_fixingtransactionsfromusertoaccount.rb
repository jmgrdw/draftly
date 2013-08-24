class Fixingtransactionsfromusertoaccount < ActiveRecord::Migration
  def change
    remove_column :transactions, :user_id
    add_column :transactions, :account_id, :integer
  end
end
