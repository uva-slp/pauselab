class MassEmail < ApplicationRecord
   validates :to, :subject, :body, presence: true
end
