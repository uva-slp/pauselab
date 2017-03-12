require 'rails_helper'

feature "redirection to the right homepage based on phase", :type => :feature do

  before :each do
    user = login_as create :artist
  end

  scenario "goes to ideas collection during ideas phase" do
    create :ideas_phase
    visit root_path
    expect(page).to have_content 'Idea Collection'
  end

  scenario "goes to proposals collection during proposals phase" do
    create :proposals_phase
    visit root_path
    expect(page).to have_content 'Submit Proposal'
  end

  scenario "goes to voting during voting phase" do
    create :voting_phase
    Proposal.all.each do |proposal|
      puts proposal.description
      puts proposal.proposal_budget
    end
    visit root_path
    expect(page).to have_content 'Vote'
  end

end
