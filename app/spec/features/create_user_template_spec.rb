require 'rails_helper'

feature 'create user template', :type => :feature do

  before :each do
    user = login_as create :admin
  end

  scenario "roles list is ordered by permission" do
    visit new_admin_user_path
    # admin is at top of stack, then we go down the list
    # if different user roles get added or get reordered in User.order_roles, this spec will need to change
    expect(page.all('#user_role > option')[0][:value]).to eq "admin"
    expect(page.all('#user_role > option')[1][:value]).to eq "moderator"
    expect(page.all('#user_role > option')[2][:value]).to eq "steerer"
    expect(page.all('#user_role > option')[3][:value]).to eq "super_artist"
    expect(page.all('#user_role > option')[4][:value]).to eq "artist"
  end

end
