require 'rails_helper'

describe CategoriesController, :type => :controller do

  before :each do
    user = sign_in (create :admin)
  end

  describe "when reading categories" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "loads all categories into @categories" do
      categories_before = Category.all.to_a
      categories = create_list(:category, 3)
      get :index
      expect(assigns(:categories)).to match_array(categories_before.concat categories)
    end
  end

  describe "when creating a category" do
    it "saves the category" do
      c = build :category
      expect {
        post :create, params: {category: c.attributes}
      }.to change { Category.count }.by 1
    end
    it "responds with redirect" do
      c = build :category
      post :create, params: {category: c.attributes}
      expect(response).to be_redirect
    end
    it "does not work for non-admins" do
      user = sign_in (create :resident)
      c = build :category
      expect {
        post :create, params: {category: c.attributes}
      }.to_not change { Category.count }
    end
  end

  describe "when updating a category" do
    it "can change name" do
      c = create :category
      put :update, params: {id: c, category: {:name => 'else'}}
      c.reload
      expect(c.name).to eq 'else'
    end
    it "responds with redirect" do
      c = create :category
      put :update, params: {id: c, category: {:name => 'else'}}
      expect(response).to be_redirect
    end
    it "does not work for non-admins" do
      user = sign_in (create :resident)
      c = create :category
      put :update, params: {id: c, category: {:name => 'else'}}
      c.reload
      expect(c.name).to_not eq 'else'
    end
  end


  describe "when deleting a category" do
    it "removes it" do
      c = create :category
      expect {
        delete :destroy, params: {id: c.id}
      }.to change {Category.count}.by -1
    end
    it "responds with redirect" do
      c = create :category
      delete :destroy, params: {id: c.id}
      expect(response).to be_redirect
    end
    it "does not work for non-admins" do
      user = sign_in (create :resident)
      c = create :category
      expect {
        delete :destroy, params: {id: c.id}
      }.to_not change {Category.count}
    end
  end

end