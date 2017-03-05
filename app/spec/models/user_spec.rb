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

  it "outputs correct full name" do
    user = build :user
    expect(user.fullname).to eq "#{user.first_name} #{user.last_name}"
  end

  it "changes role correctly" do
    user = build :artist
    expect { user.change_role :super_artist }.to change { user.role }
  end

  it "generates the right CSV" do
    user = create :user
    expect(User.to_csv).to include "id,created_at,fullname,email,phone,role"
  end

end
