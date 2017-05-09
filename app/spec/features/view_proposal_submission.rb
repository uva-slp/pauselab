require 'rails_helper'

feature 'submit proposal button changes depending on role and phase', :type => :feature do

  scenario "artists can't see submit proposal during idea collection" do
    create :ideas_phase
    user = login_as create :artist
    visit idea_cards_path
    expect(page).to_not have_selector :link_or_button, 'Submit proposal'
  end

  scenario "artists can see submit proposal during proposal collection" do
    create :proposals_phase
    user = login_as create :artist
    visit idea_cards_path
    # puts page.body
    expect(page).to have_selector :link_or_button, 'Submit proposal'
  end

  scenario "residents can't see submit proposals during idea collection" do
    create :ideas_phase
    user = login_as create :resident
    visit idea_cards_path
    # puts page.body
    expect(page).to_not have_selector :link_or_button, 'Submit proposal'
  end

  scenario "residents can't see submit proposals during proposal collection" do
    create :proposals_phase
    user = login_as create :resident
    visit idea_cards_path
    # puts page.body
    expect(page).to_not have_selector :link_or_button, 'Submit proposal'
  end


end
