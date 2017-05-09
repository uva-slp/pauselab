class Category < ApplicationRecord
  has_many :ideas
  validates :name, presence: true

  has_attached_file :icon,
    :default_url => "/images/default_icon_small.png"
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  def self.to_csv options={}
    self.gen_csv %w{id created_at name}
  end

  def to_s
    name
  end

end
