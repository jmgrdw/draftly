require 'spec_helper'

describe Team do 
	let(:player) { Player.new(full_name: "McArthur Gill", espn_url: "www.test.com", team_id: 1, position: "PG", salary: 9500, position_value: 1) }
	let(:team) { Team.new(id: 1, full_name: "Boston Celtics", abbreviation: "bos", espn_long_name: "boston-celtics", url: "espn.com/boston", city: "Boston", short_name: "Celtics", playing_today: true) }

	context "creation" do 
		it "should allow a team to be created with all the attributes" do
		  team.save
		  expect(Team.count).to eq(1)
		end

		it "should NOT create without a full_name" do
		  team.full_name = ""
		  team.save
		  expect(Team.count).to eq(0)
		end

		it "should NOT create without an abbreviation" do
		  team.abbreviation = ""
		  team.save
		  expect(Team.count).to eq(0)
		end

		it "should NOT create without an espn_long_name" do
		  team.espn_long_name = ""
		  team.save
		  expect(Team.count).to eq(0)
		end

		it "should NOT create without a url" do
		  team.url = ""
		  team.save
		  expect(Team.count).to eq(0)
		end

		it "should NOT create without a city" do
		  team.city = ""
		  team.save
		  expect(Team.count).to eq(0)
		end

		it "should NOT create without a short_name" do
		  team.short_name = ""
		  team.save
		  expect(Team.count).to eq(0)
		end
	end

	context "name" do
	  it "should return the full_name of a team" do
	    expect(team.name).to eq(team.full_name)
	  end
	end

	context "adding players to team" do
	  it "should allow a player to be added to a team" do
	    team.save
	    player.save
	    team.players << player
	    expect(team.players.count).to eq(1)
	  end
	end
end