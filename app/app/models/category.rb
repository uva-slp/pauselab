class Category < ApplicationRecord
  has_many :ideas
  validates :name, presence: true

  def self.to_csv
    self.gen_csv %w{id created_at name}
  end
end
