require 'spec_helper'

describe Game do 
	let(:home_team) { Team.new(id: 1, full_name: "Boston Celtics", abbreviation: "bos", espn_long_name: "boston-celtics", url: "espn.com/boston", city: "Boston", short_name: "Celtics", playing_today: true) }
	let(:away_team) { Team.new(id: 2, full_name: "Los Angeles Lakers", abbreviation: "lal", espn_long_name: "los-angeles-lakers", url: "espn.com/lakers", city: "Los Angeles", short_name: "Lakers", playing_today: true) }
	let(:game) { Game.new(espn_id: "400488923", date: "2013-11-04", home_team_id: 1, away_team_id: 2, game_time: "2000-01-01 06:30:00")}

	context "creation" do 
		it "should create with valid attributes" do
		  home_team.save
		  away_team.save
		  game.save
		  expect(Game.count).to eq(1)
		end
	end
end