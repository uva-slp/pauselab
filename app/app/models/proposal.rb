class Proposal < ApplicationRecord

  belongs_to :user
  belongs_to :iteration
  belongs_to :category

  has_many :proposal_comments, dependent: :destroy
  has_one :proposal_budget, dependent: :destroy

  has_and_belongs_to_many :votes, :dependent => :delete_all
  accepts_nested_attributes_for :proposal_budget

  has_attached_file :artist_cv
  validates_attachment :artist_cv, content_type: { content_type: ['application/pdf'] }

  validates :title, :essay, :description, :category_id, presence:true

  enum status: [:unchecked, :approved, :funded]

  def self.to_csv is_admin: false
    if is_admin
      self.gen_csv %w{id created_at title description essay total_cost author_name website_link comment_history_to_s number_of_votes status}
    else
      self.gen_csv %w{id created_at title description essay total_cost author_name website_link status}
    end
  end

  def total_cost
    proposal_budget.cost
  end

  def author_name
    user.fullname
  end

  # the following fields should only be exposed to admins
  def number_of_votes
    self.votes.size
  end

  def comment_history_to_s
    proposal_comments.map {|comment| "#{comment.user.fullname}: #{comment.body}"}.join("; ")
  end
end
