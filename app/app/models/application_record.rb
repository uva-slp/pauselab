class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # credit http://stackoverflow.com/a/36335591
  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

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
