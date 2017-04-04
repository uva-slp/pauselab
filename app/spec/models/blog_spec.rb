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
  it "returns the authors full name" do
    user = create :artist, :first_name => 'John', :last_name =>'Smith'
    blog = create :blog, :user =>user
    expect(blog.author_name).to eq('John Smith')
  end
end
