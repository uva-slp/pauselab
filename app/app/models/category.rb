class Category < ApplicationRecord
  has_many :ideas
  validates :name, presence: true

  has_attached_file :icon
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  def self.to_csv
    self.gen_csv %w{id created_at name}
  end
end
