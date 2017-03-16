

MagicLamp.register_fixture controller: VotesController do
  @vote = Vote.new
  render "votes/new"
end
