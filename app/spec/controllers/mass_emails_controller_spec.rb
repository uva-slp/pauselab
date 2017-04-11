require 'rails_helper'

describe MassEmailsController, type: :controller do
  before :each do
    user = sign_in (create :admin)
  end

  describe "when reading mass email" do
    it "responds with success" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "responds with success for csv" do
      get :index, :format => :csv
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "loads all mass emails into @mass_emails" do
      get :index
      expect(assigns(:mass_emails)).to match_array(MassEmail.all)
    end
  end

  describe "when creating mass email" do
    it "saves the email" do
      create :idea  # ensures idea loop from residents picks up an address
      e = build :mass_email, :to => ['resident', 'admin']
      expect {
        post :create, params: {mass_email: e.attributes}
      }.to change { MassEmail.count }.by 1
    end
    it "fails to send email with empty body" do
      e = build :mass_email, :body => ''
      expect {
        post :create, params: {mass_email: e.attributes}
      }.to_not change { MassEmail.count }
    end
    it "fails to send email with no recipients" do
      e = build :mass_email, :to => []
      expect {
        post :create, params: {mass_email: e.attributes}
      }.to_not change { MassEmail.count }
    end
  end

  describe "when destroying mass email" do
    it "deletes the email record" do
      e = create :mass_email
      expect {
        delete :destroy, params: {id: e.id}
      }.to change {MassEmail.count}.by -1
    end
  end
end
