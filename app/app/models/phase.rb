class Phase < ApplicationRecord

  enum phase: [:ideas, :proposals, :voting, :progress].freeze

  def self.get_current_phase
    if Phase.exists?
      Phase.first.phase
    else
      new_phase = Phase.new
      new_phase.save
      new_phase.phase
    end
  end

end
