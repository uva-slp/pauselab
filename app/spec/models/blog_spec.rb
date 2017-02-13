require 'rails_helper'

RSpec.describe Blog, type: :model do
  it "is valid with all fields" do
    blog = build :blog
    expect(blog).to be_valid
  end
  it "is invalid without title" do
    blog = build :blog, :title => ''
    expect(blog).to_not be_valid
  end
  it "is invalid without body" do
    blog = build :blog, :body => ''
    expect(blog).to_not be_valid
  end
end
