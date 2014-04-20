require 'spec_helper'

describe BlipsController do
  include StubCurrentUserHelper

  let(:radar) { build_stubbed(:radar) }
  let(:blip) { double('Blip') }

  before do
    user = build(:user)
    sign_in(user)
    stub_current_user_with(user)
    allow(user).to receive(:find_radar).and_return(radar)
  end

  describe "GET 'new'" do
    it "assigns a new blip" do
      get :new, radar_id: radar.to_param
      expect(assigns(:blip)).to be_a_new(Blip)
    end

    it "should be successful" do
      expect(response).to be_successful
    end

    # deprecated?
    # it { should respond_with(:success) }
  end

  describe "POST 'create'" do
    before { allow(radar).to receive(:new_blip).and_return(blip) }

    it "it attempts to save" do
      expect(blip).to receive(:save)
      post :create, radar_id: radar.to_param, blip: attributes_for(:blip)
    end

    context "with valid params" do
      before do
        allow(blip).to receive(:save).and_return(true)
        post :create, radar_id: radar.to_param, blip: attributes_for(:blip)
      end

      it "redirects" do
        expect(response).to redirect_to(radar)
      end
    end

    context "with invalid params" do
      before do
        allow(blip).to receive(:save).and_return(false)
        post :create, radar_id: radar.id, blip: attributes_for(:blip)
      end

      it "renders the 'new' template" do
        expect(response).to render_template('new')
      end
    end
  end
end
