require 'spec_helper'

describe Player do 
	let(:player) { Player.new(full_name: "McArthur Gill", espn_url: "www.test.com", team_id: 1, position: "PG", salary: 9500, position_value: 1) }
	let(:team) { Team.new(full_name: "Boston Celtics", abbreviation: "bos", espn_long_name: "boston-celtics", url: "espn.com/boston", city: "Boston", short_name: "Celtics", playing_today: true) }

	context "creation" do 
		it "should create with valid attributes" do 
			player.save
			expect(Player.count).to eq(1)
		end

		it "should NOT create without a full_name" do
			player.full_name = ""
			player.save
			expect(Player.count).to eq(0)
		end

		it "should NOT create without a team_id" do
		  player.team_id = nil
		  player.save
		  expect(Player.count).to eq(0)
		end

		it "should NOT create without a position" do
		  player.position = ""
		  player.save
		  expect(Player.count).to eq(0)
		end

		it "should NOT create without a salary" do
		  player.salary = nil
		  player.save
		  expect(Player.count).to eq(0)
		end
	end

	context "name" do 
		it "should return the full_name of the player" do
		  expect(player.name).to eq(player.full_name)
		end
	end

	context "player_show" do
	  it "should return the team abbreviation and the player name" do
	  	team.save
	    expect(player.player_show).to eq("(BOS) McArthur Gill")
	  end
	end
end