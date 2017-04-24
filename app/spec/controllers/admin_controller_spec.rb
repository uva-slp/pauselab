require 'rails_helper'

describe AdminController, type: :controller do

  before :each do
    user = sign_in (create :admin)
    @iteration = create :iteration
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

    it "Sends an email when entering voting phase" do
     put :change_phase, params: { :phase => Iteration.statuses[:voting] }
     expect(assigns(:subj)).to eq("PauseLab - Voting Period Now Open")
    end

    it "changes ideas to proposals" do
      @iteration = create :iteration, :status => Iteration.statuses[:ideas]
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("proposals")
    end
     it "changes proposals to voting" do
      @iteration = create :iteration, :status => Iteration.statuses[:proposals]
      get :next_phase, params: {:phase => @iteration.status}
      expect(Iteration.get_current.status).to eq("voting")
    end
     it "changes voting to progress" do
      @iteration = create :iteration, :status => Iteration.statuses[:voting]
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
      @iteration = create :iteration, :status => Iteration.statuses[:voting]
      expect{
      get :end_phase, params: {:phase => @iteration.status}
      }.to change{Iteration.count}.by(1)
    end
  end


  describe "when exporting data" do
    it "renders the export data template" do
      @iteration = create :iteration, :status => Iteration.statuses[:ended]
      get :export_iterations
      expect(response).to be_success
    end
  end

  describe "when edit_phase" do
    it "finds current iteration" do
      get :edit_phase
      expect(assigns(:current)).to match(Iteration.get_current)
    end
  end

  describe "when exporting a zip file" do
    it "responds with success" do
      get :export_zip, params: {:num => @iteration.id}
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

end
