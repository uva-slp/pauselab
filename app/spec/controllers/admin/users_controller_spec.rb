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

  describe "when updating a user" do
    it "updates successfully" do
      user = create :user
      put :update, params: {id: user.id, user: {:first_name => 'John Smith'}}
      expect(assigns(:user)).to match(user)
    end
    it "it rerenders when updating fails" do
      user = create :user
      put :update, params: {id: user.id, user: {:first_name => nil}}
      expect(response).to render_template('edit')
    end
  end

  #describe "when creating a new user" do
  #  it "saves the new user" do
  #    use = build :resident
  #    expect {
  #      post :create, params: {user: use.attributes}
  #      }.to change(User, :count).by(1)
  #    end
    #  it "responds with redirect" do
    #    use = build :user
    #    puts use.first_name
    #    puts use.last_name
    #    post :create, params: {user: use.attributes}

    #    expect(response).to be_redirect
    #  end
  #  end

    describe "when it deletes a user" do
      it "deletes successfully" do
        user = create :user
        expect{ 
          delete :destroy, params: {id: user.id}
          }.to change(User, :count).by(-1)
        end
        #it "flashes an error if there is an error" do
        #  user = sign_in (create :resident)
        #  res = create :resident
        #    delete :destroy, params: {id: res.id}
        #    expect(flash[:error]).to be_present
        #  end
        end
      end
