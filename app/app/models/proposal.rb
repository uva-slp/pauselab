class Proposal < ApplicationRecord

    belongs_to :user
    belongs_to :iteration
    has_many :proposal_comments
    has_one :proposal_budget

    has_and_belongs_to_many :votes, :dependent => :delete_all
    accepts_nested_attributes_for :proposal_budget, :allow_destroy => true

    has_attached_file :artist_cv
    validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }

    validates :title, :essay, :description, presence:true

    enum status: [:unchecked, :approved]

    def self.to_csv
      self.gen_csv %w{id created_at title description essay cost author_name website_link comment_history_to_s number_of_votes status}
    end

    def number_of_votes
      return self.votes.size
    end

    def author_name
      user.fullname
    end

    def comment_history_to_s
      proposal_comments.map {|comment| "#{comment.user.fullname}: #{comment.body}"}.join("; ")
    end
end
