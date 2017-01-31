class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  protected
  def self.gen_csv attributes
    CSV.generate(headers:true) do |csv|
      csv << attributes
      all.each do |obj|
        csv << attributes.map do |attribute|
          obj.send(attribute)
        end
      end
    end
  end
end
