class Landingpage < ApplicationRecord
  require 'sanitize'
  before_save :sanitize_description
  validates :title, :description, presence: true
  validates :title, uniqueness: true

  enum title: [:about, :artist_home, :steering_home, :ideas_home, :calling_artists, :voting_instructions, :proposal_instructions]

  def sanitize_description
    Sanitize.fragment(description, Sanitize::Config::RELAXED)
  end

  def self.to_csv options={}
    self.gen_csv %w{id created_at title description}
  end
end
