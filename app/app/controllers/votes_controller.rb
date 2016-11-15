class VotesController < ApplicationController

  def new
    @vote_submission = []
    3.times do
      @vote_submission << Vote.new
  end
end
