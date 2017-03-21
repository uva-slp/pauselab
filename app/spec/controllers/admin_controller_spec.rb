require 'rails_helper'

describe AdminController, type: :controller do

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
      put :change_phase, params: { :phase => @iteration.status }
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
