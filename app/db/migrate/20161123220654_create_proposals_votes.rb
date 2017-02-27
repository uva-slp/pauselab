class CreateProposalsVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :proposals_votes, id: false do |t|
      t.belongs_to :proposal
      t.belongs_to :vote
    end
  end
end
