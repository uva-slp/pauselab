class Blog < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true

  def self.to_csv
    self.gen_csv %w{id created_at title body author_name}
  end

  def author_name
    user.fullname
  end
end
