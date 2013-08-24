class FantasyTeamsController < ApplicationController

  before_filter :authenticate_user!, only: [:new, :edit, :create, :update]

  # before_filter :fetch_available_players, :only => [:new, :edit]
  before_filter :fetch_league, :only => [:new, :create, :edit, :update]
  before_filter :check_league_availability, :only => [:new, :create]
  before_filter :check_league_update_availability, :only => [:edit, :update]
  before_filter :fetch_players_from_league_games, :only => [:new, :edit]
  
  before_filter :confirm_account_balance_for_league, :only => [:new, :create]
  
  def new
    @fantasy_team = FantasyTeam.build_fantasy_team_from_league(@league.league_type, :league_id => @league.id)
  end
  
  def edit
    @fantasy_team = FantasyTeam.find(params[:id])
  end
  
  def create
    @user = current_user
    @fantasy_team = FantasyTeam.build_fantasy_team_from_league(@league.league_type, params[:fantasy_team])
    @fantasy_team.user_id = current_user.id
    
    if @fantasy_team.update_attributes(params[:fantasy_team])
      @user.subtract_league_fee_and_record_transaction(@fantasy_team)
      # @user.subtract_league_fee_from_account(@league)
      redirect_to fantasy_team_path(@fantasy_team), notice: "team saved"
    else
      redirect_to new_fantasy_team_path(:league_id => @league.id, :league_type => @league.league_type), :alert => "legit invalid"
    end
    
  end
    
  def show
    @fantasy_team = FantasyTeam.find(params[:id])
  end
  
  def update
    @fantasy_team = FantasyTeam.find(params[:id])
    if @fantasy_team.update_attributes(params[:fantasy_team])
      redirect_to fantasy_team_path(@fantasy_team), :notice => "updated team"
    else
      redirect_to league_path(@league), :alert => "could not update team"
    end
  end
  
  private
    def fetch_league
      @league = params[:fantasy_team] ? League.find(params[:fantasy_team][:league_id]) : League.find(params[:league_id])
    end
    
    def check_league_update_availability
      redirect_to root_path, :alert => "Too late to join or update your team" unless @league.not_too_late_to_join_or_update?
    end
    
    def check_league_availability
      redirect_to root_path, :alert => "League is closed." unless @league.available?
    end
    
    def confirm_account_balance_for_league
      @user = current_user
      redirect_to root_path, :alert => "Not enough funds." unless @user.has_balance_for_league_fee?(@league)
    end
    
    # this is garbage. on the to-do list
    def fetch_players_from_league_games
      @league = params[:fantasy_team] ? League.find(params[:fantasy_team][:league_id]) : League.find(params[:league_id])
      @team_ids = @league.games.select([:home_team_id, :away_team_id]).map do |game|
        [game.home_team_id, game.away_team_id]
      end
      @team_ids = @team_ids.flatten.uniq
      @point_guards, @shooting_guards, @small_forwards, @power_forwards, @centers = [], [], [], [], []

      @team_ids.each do |team_id|
        team = Team.includes(:players).find(team_id)
        team.players.each do |player|
          case player.position
          when "PG"
            @point_guards << player
          when "SG"
            @shooting_guards << player
          when "SF"
            @small_forwards << player
          when "PF"
            @power_forwards << player
          when "C"
            @centers << player
          end
        end
      end
    end
    
    
end