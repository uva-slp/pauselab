require 'test_helper'

class PhaseTest < ActiveSupport::TestCase

  test "should save" do
    phase = Phase.new
    phase.phase = 0
    assert phase.save, "could not save phase"
  end

end
