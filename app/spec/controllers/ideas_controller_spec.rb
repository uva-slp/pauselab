require 'rails_helper'

describe IdeasController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting idea index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end
    it "loads all ideas into @ideas" do
      idea = create_list(:idea, 10, iteration: @iteration)
      get :index
      expect(assigns(:ideas)).to match_array(idea)
    end
    it "does not show unapproved ideas to residents" do
      user = sign_in (create :resident)
      idea1 = create_list(:idea, 3, iteration: @iteration, status: :approved)
      idea2 = create_list(:idea, 3, iteration: @iteration, status: :unchecked)
      get :index
      expect(assigns(:ideas)).to match_array(idea1)
    end
  end

  describe "when creating an idea" do
    it "saves the idea" do
      i = build :idea
      expect {
        post :create, params: {idea: i.attributes}
        }.to change { Idea.count }.by 1
      end
      it "associates new idea with current iteration" do
        iter = create :iteration
        idea = build :idea, :iteration => nil
        post :create, params: {idea: idea.attributes}
        idea = Idea.last
        expect(idea.iteration_id).to eq iter.id
      end
      it "responds with redirect" do
        i = build :idea
        post :create, params: {idea: i.attributes}
        expect(response).to be_redirect
      end
    end

    describe "when deleting an idea" do
      it "removes the idea" do
        i = create :idea
        expect {
          delete :destroy, params: {id: i.id}
          }.to change {Idea.count}.by -1
        end
        it "responds with redirect" do
          i = create :idea
          delete :destroy, params: {id: i.id}
          expect(response).to be_redirect
        end
      end

      describe "when updating an idea" do
        it "updates description" do
          i = create :idea
          put :update, params: {id: i, idea: {:description => 'Hello, World!'}}
          i.reload
          expect(i.description).to eq 'Hello, World!'
        end
        it "updates first name" do
          i = create :idea
          put :update, params: {id: i, idea: {:first_name => 'Joe'}}
          i.reload
          expect(i.first_name).to eq 'Joe'
        end
        it "updates last name" do
          i = create :idea
          put :update, params: {id: i, idea: {:last_name => 'Schmoe'}}
          i.reload
          expect(i.last_name).to eq 'Schmoe'
        end
        it "updates email" do
          i = create :idea
          put :update, params: {id: i, idea: {:email => 'jschmoe@gmail.com'}}
          i.reload
          expect(i.email).to eq 'jschmoe@gmail.com'
        end
        it "updates phone" do
          i = create :idea
          put :update, params: {id: i, idea: {:phone => '1234567890'}}
          i.reload
          expect(i.phone).to eq '1234567890'
        end
        it "updates address" do
          i = create :idea
          put :update, params: {id: i, idea: {:address => '1 Main St'}}
          i.reload
          expect(i.address).to eq '1 Main St'
        end
        it "responds with redirect" do
          i = create :idea
          put :update, params: {id: i, idea: {:description => 'Hello, World!'}}
          expect(response).to be_redirect
        end
        it "should render the edit screen again if the model doesn't save" do
          idea = create :idea
          put :update, params: {id: idea, idea: {:description=> nil}}
          response.should render_template :edit
        end
    # TODO: validation checks
  end

  describe "when creating an idea" do
    it "saves the idea" do
      i = build :idea
      expect {
        post :create, params: {idea: i.attributes}
        }.to change { Idea.count }.by 1
      end
      it "associates new idea with current iteration" do
        iter = create :iteration
        idea = build :idea, :iteration => nil
        post :create, params: {idea: idea.attributes}
        idea = Idea.last
        expect(idea.iteration_id).to eq iter.id
      end
      it "responds with redirect" do
        i = build :idea
        post :create, params: {idea: i.attributes}
        expect(response).to be_redirect
      end
      it "if unable to save it rerenders 'new'" do
        idea = build :bad_idea
        post :create, params: {idea: idea.attributes}
        response.should render_template :new
      end
    end

    describe "when liking an idea" do
      it "updates like count of idea" do
        i = create :idea
        expect {
          get :like, params: {id: i.id}, xhr: true
          }.to change {Idea.find(i.id).likes}.by 1
        end
        it "creates likes cookie if nil" do
          i = create :idea
          get :like, params: {id: i.id}, xhr: true
          expect(cookies[:likes]).to eq "[#{i.id}]"
        end
        it "updates likes cookie if not nil" do
          cookies[:likes] = "[12]"
          i = create :idea
          get :like, params: {id: i.id}, xhr: true
          expect(cookies[:likes]).to eq "[12,#{i.id}]"
        end
      end

      describe "when unliking an idea" do
        it "updates like count" do
          i = create :idea
          cookies[:likes] = "[#{i.id}]"
          expect {
            get :like, params: {id: i.id}, xhr: true
            }.to change {Idea.find(i.id).likes}.by -1
          end
          it "updates cookie" do
            i = create :idea
            cookies[:likes] = "[#{i.id}]"
            get :like, params: {id: i.id}, xhr: true
            expect(cookies[:likes]).to eq "[]"
          end
        end		

        describe "GET #edit" do
          it "renders a edit template for ideas" do
            idea = create :idea
            get :edit, params: { id: idea.id }
            expect(response).to render_template(:edit)
          end
        end    

        describe "GET #show" do
          it "renders the #show view" do
            idea = create :idea
            get :show, params: { id: idea.id }
            expect(response).to render_template(:show)
          end
        end
      end
