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
      put :update, params: {id: lp, landingpage: {:title => 'Front Page'}}
      lp.reload
      expect(lp.title).to eq 'Front Page'
    end
    it "responds with redirect" do
      lp = create :landingpage
      put :update, params: {id: lp, landingpage: {:description => 'Hello, World!'}}
      expect(response).to be_redirect
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
    end
end