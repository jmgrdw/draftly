class UsersController < ApplicationController

  before_filter :authenticate_user!
  
  def show
    @user = current_user
    @fantasy_teams = @user.fantasy_teams.includes(:league, :players)
  end
  
  def add_funds
    @user = current_user
    @products = Product.all
  end
  
  def live_entries
    @user = current_user
    @fantasy_teams = @user.current_fantasy_teams
  end
  
  def upcoming_entries
    @user = current_user
    @fantasy_teams = @user.upcoming_fantasy_teams
  end
  
  def entry_history
    @user = current_user
    @fantasy_teams = @user.fantasy_teams
  end
  
  

end