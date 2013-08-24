class TransactionHistory < ActiveRecord::Base
  attr_accessible :account_id, :fantasy_team_id, :value
  
  belongs_to :account
  belongs_to :fantasy_team
  
end
