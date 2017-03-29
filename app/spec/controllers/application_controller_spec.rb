require 'rails_helper'

describe ApplicationController, :type => :controller do

  before :each do
    user = sign_in (create :admin)
  end
  
  describe "When logging in as a specific user," do
    it "admins redirect to admin page" do
      user = create :admin
      expect(controller.after_sign_in_path_for(user)).to eq(admin_users_url)
  end
  it "moderators redirect to mod page" do
      user = create :moderator
      expect(controller.after_sign_in_path_for(user)).to eq(admin_edit_phase_url)
  end
  it "artist redirect to artists page" do
      user = create :artist
      expect(controller.after_sign_in_path_for(user)).to eq(artist_home_url)
  end
  it "steerer redirect to steerer page" do
      user = create :steerer
      expect(controller.after_sign_in_path_for(user)).to eq(steering_home_url)
  end
  it "resident redirect to resident page" do
      user = create :resident
      expect(controller.after_sign_in_path_for(user)).to eq(root_url)
  end
end
end
