class CurrentStat < ActiveRecord::Base
  ASSISTS_WEIGHT, REBOUNDS_WEIGHT, POINTS_WEIGHT = 1, 1, 1
  STEALS_WEIGHT, BLOCKS_WEIGHT = 2, 2
  TURNOVERS_WEIGHT = -1
  
  
  attr_accessible :assists, :blocks, :finished, :game_id, :minutes, :player_id, :points, :rebounds, :steals, :turnovers
  
  belongs_to :player
  belongs_to :game
  
  def finished?
    finished == true ? "T" : "F"
  end
  
  
  def total
    sum = assists*ASSISTS_WEIGHT + rebounds*REBOUNDS_WEIGHT + points*POINTS_WEIGHT + steals*STEALS_WEIGHT + blocks*BLOCKS_WEIGHT + turnovers*TURNOVERS_WEIGHT
  end
  
  def player_name
    player.full_name
  end
  
  
  def self.update_randomly
    @r = (1..8).to_a
    @stats = CurrentStat.all
    @stats.each do |s|
      s.minutes += @r.sample
      s.points += @r.sample
      s.rebounds += @r.sample
      s.assists += @r.sample
      s.steals += @r.sample
      s.blocks += @r.sample
      s.turnovers += @r.sample
      s.save
    end
  end
end
