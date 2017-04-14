require "rails_helper"

feature "adding ideas", :type => :feature do

  before :each do
    user = login_as create :resident
  end

  scenario "allow a resident to add an idea" do
    create_list :category, 3 # create 3 sample categories
    # puts Category.all.select(:id, :name).to_yaml
    idea = build :idea, category_id: Category.last.id
    visit new_idea_path
    fill_in 'First name', with: idea.first_name
    fill_in 'Last name', with: idea.last_name
    fill_in 'Email', with: idea.email
    fill_in 'Phone', with: idea.phone
    fill_in 'Description', with: idea.description
    select idea.category.name, from: ' Category', :match => :first

    # a bit of a cop-out but simulating js is rather difficult for now
    first('input#idea_lat', visible: false).set idea.lat
    first('input#idea_lng', visible: false).set idea.lng
    first('input#idea_address', visible: false).set idea.address

    click_on 'Submit'
    expect(page).to have_content (I18n.t 'ideas.save_success').to_s
  end
end
