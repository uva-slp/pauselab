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
    #idea.author.should == 'John Smith'
    expect(idea.author).to eq 'John Smith'
  end



end
