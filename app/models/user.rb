class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  has_many :fantasy_teams
  has_one :account

  after_create :create_user_account
  
  validates_presence_of :username
  validates_uniqueness_of :username
  
  def has_balance_for_league_fee?(league)
    account.has_balance_for_league_fee?(league)
  end

  def create_user_account
    account = Account.new
    account.user_id = self.id
    account.save
  end
  
  def subtract_league_fee_and_record_transaction(fantasy_team)
    account.subtract_league_fee_and_record_transaction(fantasy_team)
  end
  
  def current_fantasy_teams
    fantasy_teams.current_fantasy_teams.includes(:league, :players)
  end
  
  def upcoming_fantasy_teams
    fantasy_teams.upcoming_fantasy_teams.includes(:league, :players)
  end
  
  def current_fantasy_teams_count
    current_fantasy_teams.count
  end
  
  def upcoming_fantasy_teams_count
    upcoming_fantasy_teams.count
  end
  
  def fantasy_teams_count
    fantasy_teams.count
  end
  
end
