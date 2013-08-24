class HomeController < ApplicationController
  def index
    # @leagues = League.all
    @leagues = League.finalized_leagues
  end
end
