require 'rails_helper'

RSpec.describe Idea, type: :model do

  it "is valid with all fields" do
    idea = build :idea
    expect(idea).to be_valid
  end

  it 'is not valid without last_name' do
    idea = build :idea, :last_name => ''
    expect(idea).to_not be_valid
  end

  it 'is not valid without first_name' do
    idea = build :idea, :first_name => ''
    expect(idea).to_not be_valid
  end

  it 'is not valid without email' do
    idea = build :idea, :email => ''
    expect(idea).to_not be_valid
  end

  it 'is not valid without lat/lng' do
    idea = build :idea, :lat => '', :lng => ''
    expect(idea).to_not be_valid
  end

  it 'is not valid without category' do
    idea = build :idea, :category => nil
    expect(idea).to_not be_valid
  end

  it 'is not valid with a less than 10 character phone' do
    idea = build(:idea, :phone => 55555)
    expect(idea).to_not be_valid
  end

  it 'is not valid with a more than 10 character phone' do
    idea = build(:idea, :phone => 555555555555)
    expect(idea).to_not be_valid
  end

  it 'is not valid with a improper email' do
    idea = build(:idea, :email => 'email')
    expect(idea).to_not be_valid
  end

  it 'is not valid with an email with no domain' do
    idea = build(:idea, :email => 'email@email')
    expect(idea).to_not be_valid
  end

  it 'is not valid without a description' do
    idea = build(:idea, :description => '')
    expect(idea).to_not be_valid
  end

  it "gives the author's first and last name" do
    idea = create :idea, :first_name=>'John', :last_name=>'Smith'
    expect(idea.author).to eq 'John Smith'
  end

  it "returns the category name" do
    category = create :category, :name => 'Parks'
    idea = create :idea, :category =>category
    expect(idea.category_name).to eq('Parks')
  end

  #it "returns empty string if there is no name" do
  #  idea = create :idea, :first_name => nil, :last_name => nil
  #  expect(idea.author).to eq ""
  #end

end
