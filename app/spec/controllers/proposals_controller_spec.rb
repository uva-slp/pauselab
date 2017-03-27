require 'rails_helper'

describe ProposalsController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
  end

  describe "when getting proposal index" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end
    it "loads all proposals into @proposals" do
      proposals = create_list(:proposal, 10, iteration: @iteration)
      get :index
      expect(assigns(:proposals)).to match_array(proposals)
    end
    it "does not show unapproved proposals to residents" do
      user = sign_in(create :resident)
      proposal1 = create_list(:proposal, 3, iteration: @iteration, status: :approved)
      proposal2 = create_list(:proposal, 3, iteration: @iteration, status: :unchecked)
      get :index
      expect(assigns(:proposals)).to match_array(proposal1)
    end
  end

  describe "when creating proposal" do
    it "saves the proposal" do
      proposal = build :proposal
      expect {
        post :create, params: {proposal: proposal.attributes}
        }.to change {Proposal.count}.by 1
      end
      it "associates new proposal with current iteration" do
        iter = create :iteration
        proposal = build :proposal, :iteration => nil
        post :create, params: {proposal: proposal.attributes}
        proposal = Proposal.last
        expect(proposal.iteration_id).to eq iter.id
      end
      it "responds with redirect" do
        proposal = build :proposal
        post :create, params: {proposal: proposal.attributes}
        expect(response).to be_redirect
      end
      it "gives an error when a required field isn't present" do
        proposal = build :invalid_proposal
        post :create, params: {proposal: proposal.attributes}
        expect(response).to render_template(:new)
      end
      it "does not work if user is resident" do
        user = sign_in (create :resident)
        proposal = build :proposal
        expect {
          post :create, params: {proposal: proposal.attributes}
          }.to_not change {Proposal.count}
        end
      end

      describe "when deleting proposal" do
        it "removes the proposal" do
          proposal = create :proposal
          expect {
            delete :destroy, params: {id: proposal.id}
            }.to change {Proposal.count}.by -1
          end
          it "responds with redirect" do
            proposal = create :proposal
            delete :destroy, params: {id: proposal.id}
            expect(response).to be_redirect
          end
          it "works for the artist who made the proposal" do
            artist = create :artist
            user = sign_in (artist)
            proposal = create :proposal, :user_id => artist.id
            expect {
              delete :destroy, params: {id: proposal.id}
              }.to change {Proposal.count}.by -1
            end
            it "does not work for resident" do
              proposal = create :proposal
              user = sign_in (create :resident)
              expect {
                delete :destroy, params: {id: proposal.id}
                }.to_not change {Proposal.count}
              end
            end

            describe "when updating a proposal description" do
              it "can update description" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:description => 'Hello, World!'}}
                proposal.reload
                expect(proposal.description).to eq 'Hello, World!'
              end
              it "responds with redirect" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:description => 'Hello, World!'}}
                expect(response).to be_redirect
              end
            end
            describe "when updating a proposal title" do
              it "can update title" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:title => 'New Title'}}
                proposal.reload
                expect(proposal.title).to eq 'New Title'
              end
              it "responds with redirect" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:title => 'New Title'}}
                expect(response).to be_redirect
              end
            end
            describe "when updating a proposal essay" do
              it "can update essay" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:essay => 'New essay'}}
                proposal.reload
                expect(proposal.essay).to eq 'New essay'
              end
              it "responds with redirect" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:essay => 'New essay'}}
                expect(response).to be_redirect
              end
            end
            describe "when updating a proposal website link" do
              it "can update essay" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:website_link => 'www.test.com'}}
                proposal.reload
                expect(proposal.website_link).to eq 'www.test.com'
              end
              it "responds with redirect" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:website_link => 'www.test.com'}}
                expect(response).to be_redirect
              end
              it "should render the edit screen again if the model doesn't save" do
                proposal = create :proposal
                put :update, params: {id: proposal, proposal: {:title=> nil}}
                expect(response).to render_template(:edit)
              end
            end

            describe "GET #edit" do
              it "renders a edit template for @category" do
                proposal = create :proposal
                get :edit, params: { id: proposal.id }
                expect(response).to render_template(:edit)
              end
            end

            describe "GET #show" do
              it "assigns the requested category to @ccategory" do
                proposal = create :proposal
                get :show, params: { id: proposal.id }
                expect(assigns(:proposal)).to eq(proposal)
              end

              it "renders the #show view" do
                proposal = create :proposal
                get :show, params: { id: proposal.id }
                expect(response).to render_template(:show)
              end
            end
          end
