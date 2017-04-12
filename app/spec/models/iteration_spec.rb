require 'rails_helper'

RSpec.describe Iteration, type: :model do


  it "returns interval for passed iterations" do
    created = DateTime.new(2017,1,31,23)
    ended1 = DateTime.new(2017,6,1)
    itr = create :iteration, :created_at => created, :ended => ended1
    expect(itr.get_interval).to eq("01/31/17 -- 06/01/17")
  end
  it "returns the iteration interval" do
    created = DateTime.new(2017,1,31,23)
    itr = create :iteration, :created_at => created, :ended => nil
    expect(itr.get_interval).to eq("01/31/17 -- ...")
  end
  it "creates a new iteration when none exist" do
    Iteration.delete_all
    expect(Iteration.get_current.status).to eq("ideas")
  end

end
