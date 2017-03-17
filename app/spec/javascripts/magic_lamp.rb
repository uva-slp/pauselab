

MagicLamp.register_fixture controller: VotesController do
  10.times do
    FactoryGirl.create :proposal,
      :status => :approved
  end
  @vote = Vote.new
  render "votes/new"
end
