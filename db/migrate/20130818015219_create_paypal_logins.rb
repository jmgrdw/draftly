class CreatePaypalLogins < ActiveRecord::Migration
  def change
    create_table :paypal_logins do |t|

      t.timestamps
    end
  end
end
