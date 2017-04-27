class Landingpage < ApplicationRecord
  require 'sanitize'
  before_save :sanitize_description
  validates :title, :description, presence: true
  validates :title, uniqueness: true

  enum title: [:about, :artist_home, :steering_home, :ideas_home]

  def sanitize_description
    Sanitize.fragment(description, Sanitize::Config::RELAXED)
  end
end
