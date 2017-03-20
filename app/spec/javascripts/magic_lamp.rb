

MagicLamp.register_fixture controller: VotesController do
  10.times do
    FactoryGirl.create :proposal,
      :status => :approved
  end
  @vote = Vote.new
  render "votes/new"
end

MagicLamp.register_fixture controller: IdeasController do
  10.times do
    FactoryGirl.create :idea,
      :status => :approved
  end
  @ideas = Idea.all
  render "ideas/proposal_collection"
end
