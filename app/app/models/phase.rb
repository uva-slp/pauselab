class Phase < ApplicationRecord

  enum phase: [:ideas, :proposals, :voting, :progress].freeze

  def self.get_current
    if Phase.exists?
      Phase.first
    else
      ph = Phase.new
      ph.save
      ph
    end
  end

end
