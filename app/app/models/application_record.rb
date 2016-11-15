class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  require 'sanitize'
  before_save :sanitize_description

  def sanitize_description
  	Sanitize.fragment(description, Sanitize::Config::RELAXED)
  end
end
