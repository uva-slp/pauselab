class Vote < ApplicationRecord
  has_and_belongs_to_many :proposals

  enum status: [:unchecked, :approved]
end
