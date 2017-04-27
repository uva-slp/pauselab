require 'rails_helper'

describe LandingpagesController, type: :controller do

  before :each do
    user = sign_in (create :admin)
  end

  describe "when updating a landingpage post" do
    it "updates the description" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:description => 'Hello, World!'}}
      lp.reload
      expect(lp.description).to eq 'Hello, World!'
    end
    it "updates the title" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => :about}}
      lp.reload
      expect(lp.title).to eq 'about'
    end
    it "responds with redirect" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:description => 'Hello, World!'}}
      expect(response).to be_redirect
    end
    it "for Homepage it redirects to correct place" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => :ideas_home}}
      expect(response).to redirect_to(ideas_home_path)
    end
    it "for Artist Homepage it redirects to correct place" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => :artist_home}}
      expect(response).to redirect_to(artist_home_url)
    end
    it "for steering Homepage it redirects to correct place" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => :steering_home}}
      expect(response).to redirect_to(steering_home_url)
    end
    it "for About Us it redirects to correct place" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => :about}}
      expect(response).to redirect_to(about_url)
    end
    it "it re-renders on update failure" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:title => nil}}
      expect(response).to render_template(:edit)
    end
  end

  describe "when creating a landing page post" do
    it "does not work for non-admins" do
      user = sign_in (create :steerer)
      lp = build :landingpage
      expect {
        post :create, params: {landingpage: lp.attributes}
      }.to_not change {Landingpage.count}
    end
    it "saves the post" do
      lp = build :landingpage
      expect {
        post :create, params: {landingpage: lp.attributes}
      }.to change { Landingpage.count }.by 1
    end
    it "responds with redirect" do
      lp = build :landingpage
      post :create, params: {landingpage: lp.attributes}
      expect(response).to be_redirect
    end
    it "does not save on error" do
      create :landingpage, :title => :about
      lp = build :landingpage, :title => :about # fails uniqueness check
      expect {
        post :create, params: {landingpage: lp.attributes}
      }.to_not change { Landingpage.count }
    end
    it "rerenders template new on error" do
      create :landingpage, :title => :about
      lp = build :landingpage, :title => :about # fails uniqueness check
      post :create, params: {landingpage: lp.attributes}
      expect(response).to render_template(:new)
    end
  end

  describe "GET #new" do
    it "renders the new landingpage template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET #edit" do
    it "renders a edit template for @landingpage" do
      lp = create :landingpage
      get :edit, params: { id: lp.id }
      expect(response).to render_template(:edit)
    end
  end

end
