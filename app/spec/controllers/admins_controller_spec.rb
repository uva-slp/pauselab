require 'rails_helper'

describe AdminsController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting admin index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "when getting index_users" do
    it "responds with success" do
      get :index_users
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the list_users template" do
      get :index_users
      expect(response).to render_template('index_users')
    end
    #it "loads all users into @users" do
    #  @users = create_list(:user, 20)
    #  get :index_users
    #  expect(assigns(:users)).to match_array(@users)
    #end
  end

  describe "when getting show_users" do
    it "responds with success" do
      user = create :resident
      get :show_user, :num => user.id
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the show_user template on GET" do
      user = create :resident
      get :show_user, :num => user.id
      expect(response).to render_template('show_user')
    end
    it "loads user based on id" do
      user = create :resident
      get :show_user, :num => user.id
      expect(assigns(:user)).to match(user)
    end
  end

  describe "when getting change_phase" do
    it "responds with success" do
      get :change_phase
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the edit_phase template" do
      get :change_phase
      expect(response).to render_template('edit_phase')
    end
    it "updates to new phase" do
      new_phase = 2
      @iteration.status = new_phase
      put :change_phase, :phase => @iteration.status
      expect(Iteration.get_current).to match(@iteration)
    end
    # it "updates to invalid phase" do
    #  new_phase = 5
    #  @iteration.status = new_phase
    #  put :change_phase, :phase => @iteration.status
    #  expect(Iteration.get_current).to match(@iteration)
    #end

  end

end
