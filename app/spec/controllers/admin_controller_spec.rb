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
  
   #it "Sends an email when entering voting phase" do
   #   new_phase = 3
   #   @iteration.status = new_phase
   #   put :change_phase, params: { :phase => @iteration.status }
      #expect(subj).to exist
   #    expect(assigns(:subj)).to eq("PauseLab - Voting Period Now Open")
    #end

    it "changes ideas to proposals" do
      @iteration = create :iteration, :status => 0
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("proposals")
    end
     it "changes proposals to voting" do
      @iteration = create :iteration, :status => 1
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("voting")
    end
     it "changes voting to progress" do
      @iteration = create :iteration, :status => 2
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("progress")
    end
     it "changes undefined to progress" do
      @iteration = create :iteration, :status => nil
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("progress")
    end
  end

  describe "when ending an iteration" do
    it "it creates a new iteration" do
      @iteration = create :iteration, :status => 2
      expect{
      get :end_phase, params: {:phase => @iteration.status}
      }.to change{Iteration.count}.by(1)
      #expect(Iteration.count).to eq("ended")
  end
end


describe "when exporting data" do
  it "renders the export data template" do
    @iteration = create :iteration, :status => "ended"
    get :export_iterations
    expect(response).to be_success
  end
end

end
