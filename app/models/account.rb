class Account < ActiveRecord::Base
  attr_accessible :balance, :user_id
  
  belongs_to :user
  has_many :transactions
  has_many :products, :through => :transactions
  
  has_many :transaction_histories
  
  def add_funds_and_record_transaction(amount)
    add_funds_from_purchase(amount)
    create_transaction_add_funds(amount)
  end
  
  def add_funds_from_purchase(amount)
    self.balance += amount
    self.save
  end
  
  def subtract_league_fee_and_record_transaction(fantasy_team)
    subtract_league_fee(fantasy_team.league)
    create_transaction_join_league(fantasy_team)
  end
  
  def subtract_league_fee(league)
    self.balance -= league.fee
    self.save
  end
  
  def has_balance_for_league_fee?(league)
    balance >= league.fee
  end
  
  def create_transaction_join_league(fantasy_team)
    league_fee = fantasy_team.league.fee*-1
    new_record = TransactionHistory.new(:value => league_fee, :fantasy_team_id => fantasy_team.id, :account_id => self.id)
    new_record.save
  end
  

  def create_transaction_add_funds(value)
    new_record = TransactionHistory.new(:value => value, :account_id => self.id)
    new_record.save
  end
  
  # def create_transaction_win_league(fantasy_team)
  # end
  
  # def create_transaction_withdraw_funds
  # end
  
  
end
