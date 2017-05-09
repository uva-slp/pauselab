class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :iteration
  validates :title, :body, presence: true

  def self.to_csv options={}
    self.gen_csv %w{id created_at title body author_name}
  end

  def author_name
    user.fullname
  end

  def preview
    require 'sanitize'
    Sanitize.fragment body
  end

end
