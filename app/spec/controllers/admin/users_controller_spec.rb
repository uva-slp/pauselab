require 'rails_helper'

describe Admin::UsersController, type: :controller do
  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting user index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the list_users template" do
      get :index
      expect(response).to render_template('index')
    end
    #it "loads all users into @users" do
    #  @users = create_list(:user, 20)
    #  get :index
    #  expect(assigns(:users)).to match_array(@users)
    #end
  end

  describe "when showing user" do
    it "responds with success" do
      user = create :resident
      get :show, params: { id: user.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the show template on GET" do
      user = create :resident
      get :show, params: { id: user.id }
      expect(response).to render_template('show')
    end
    it "loads user based on id" do
      user = create :resident
      get :show, params: { id: user.id }
      expect(assigns(:user)).to match(user)
    end
  end

end
