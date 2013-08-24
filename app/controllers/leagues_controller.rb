require 'date'

class LeaguesController < ApplicationController
  
  before_filter :parse_start_date_and_end_date, :only => [:create, :update]
  
  before_filter :confirm_user_admin, :except => [:show]
  
  def new
    @league = League.new
  end
  
  def create
    @league = League.new(params[:league])
    @league.start_date = @start_date
    @league.end_date = @end_date
    if @league.save
      redirect_to add_teams_league_path(@league), notice: "add teams"
      # redirect_to root_path, notice: "created league"
    else
      redirect_to root_path, error: "league was not created"
    end  
  end
  
  def show
    @league = League.find(params[:id])
  end
  
  def edit
    @league = League.find(params[:id])
  end
  
  def add_teams
    @league = League.find(params[:id])
    @games = Game.includes(:home_team, :away_team).find_within_date_range(@league.start_date, @league.end_date)

  end
  
  def update
    @league = League.find(params[:id])
    @league.start_date = @start_date if @start_date
    @league.end_date = @end_date if @end_date
    if @league.update_attributes(params[:league])
      redirect_to league_path(@league), notice: "league updated"
    else
      redirect_to root_path, error: "league not updated"
    end
  end
  
  private
    def parse_start_date_and_end_date
      if params[:start_date] && params[:end_date]
        start_date = params.delete :start_date 
        end_date = params.delete :end_date
        @start_date = Date.new(start_date[:year].to_i, start_date[:month].to_i, start_date[:day].to_i)
        @end_date = Date.new(end_date[:year].to_i, end_date[:month].to_i, end_date[:day].to_i)
      end
    end
    
    def confirm_user_admin
      redirect_to root_path unless current_user.admin
    end
    
end