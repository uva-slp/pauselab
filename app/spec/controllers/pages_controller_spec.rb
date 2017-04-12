require 'rails_helper'

describe PagesController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when loading ideas" do
    it "it returns with success" do
      idea1 = create_list(:idea, 3, iteration: @iteration, status: :approved)
      get :get_ideas
      expect(response).to be_redirect
      #expect(response).to render_template(:ideas)
    end
  end

#describe "when going home" do
#    it "it returns with" do
#      itr = create :iteration {}
#      get :get_ideas
#      expect(response).to be_redirect
      #expect(response).to render_template(:ideas)
#    end

#end

  describe "getting categories" do
    it "it response with usccess" do
      cat1 = create_list(:category, 3)
      get :get_categories
      expect(response).to be_success
      #expect(response).to render_template(:ideas)
    end
  end


  describe "when getting user info" do
    it "it gets correct user's info" do
      user = sign_in (create :resident) # user = [[id], "hash"]
      get :user_info
      expect(response).to be_success
      expect(assigns(:user).id).to eq(user[0][0])
    end
  end

end
