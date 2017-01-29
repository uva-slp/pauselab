class MassEmail < ApplicationRecord
   validates :to, :subject, :body, presence: true

   def self.to_csv
     self.gen_csv %w{id created_at to subject body}
   end
end
