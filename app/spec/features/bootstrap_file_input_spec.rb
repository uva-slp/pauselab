require 'rails_helper'

feature 'bootstrap file input', :type => :feature do

  before :each do
    user = login_as create :artist
  end

  scenario "render file input correctly" do
    visit new_proposal_path
    expect(page).to have_css 'input.custom-file-input'
  end

end
