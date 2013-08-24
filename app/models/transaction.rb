class Transaction < ActiveRecord::Base
  attr_accessible :product_id, :account_id
  
  belongs_to :product
  belongs_to :account
end
