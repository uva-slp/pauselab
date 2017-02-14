require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with all fields" do
  	user = build :user
  	expect(user).to be_valid
  end

  it "is invalid without first name" do 
  	user = build :user, :first_name => ''
  	expect(user).to_not be_valid
  end

  it "is invalid without last_name" do 
  	user = build :user, :last_name => ''
  	expect(user).to_not be_valid
  end

  it "is valid without phone" do 
  	user = build :user, :phone => ''
  	expect(user).to be_valid
  end

  it "is invalid without email" do 
  	user = build :user, :email => ''
  	expect(user).to_not be_valid
  end

  it "is invalid without password" do 
  	user = build :user, :password => ''
  	expect(user).to_not be_valid
  end
end