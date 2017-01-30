class Iteration < ApplicationRecord
  enum status: [:ideas, :proposals, :voting, :progress, :ended].freeze

  def self.get_current
    if Iteration.exists?
      Iteration.last
    else
      iter = Iteration.new
      iter.save
      iter
    end
  end

  def get_interval
    if ended.nil?
      "#{created_at.strftime('%x')} -- ..."
    else
      "#{created_at.strftime('%x')} -- #{ended.strftime('%x')}"
    end
  end


end
