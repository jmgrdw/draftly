module LeaguesHelper
  
  def link_to_join_league_if_available(league)
    if league.available?
      link_to "enter", new_fantasy_team_path(:league_type => league.league_type, :league_id => league.id ), :class => 'btn btn-success btn-mini'
    else
      link_to "closed", '#', :class => 'btn btn-danger btn-mini'
    end
  end
  
  
end