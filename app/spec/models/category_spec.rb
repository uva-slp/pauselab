require 'rails_helper'

RSpec.describe Category, type: :model do
  it "is valid with a name" do
    category = build :category
    expect(category).to be_valid
  end
  it "is invalid without a name" do
    category = build :category, :name => ''
    expect(category).to_not be_valid
  end
end
