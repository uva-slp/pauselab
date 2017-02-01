require 'rails_helper'

describe CategoriesController, :type => :controller do

  before :each do
    user = sign_in (create :admin)
  end

  it "creates the category" do
    c = build :category
    expect {
      post :create, params: {category: c.attributes}
    }.to change { Category.count }.by 1
  end

  it "updates category" do
    c = create :category
    put :update, params: {id: c, category: {:name => 'else'}}
    c.reload
    expect(c.name).to eq 'else'
  end

  it "removes it" do
    c = create :category
    expect {
      delete :destroy, params: {id: c.id}
    }.to change {Category.count}.by -1
  end

end
