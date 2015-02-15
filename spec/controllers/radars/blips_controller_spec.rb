require "rails_helper"

describe Radars::BlipsController do
  include StubCurrentUserHelper

  let(:radar) { build_stubbed(:radar) }
  let(:blip) { double("Blip") }

  before do
    user = build(:user)
    sign_in(user)
    stub_current_user_with(user)
    allow(Radar).to receive(:find).and_return(radar)
  end

  describe "GET 'new'" do
    specify do
      pending
      get :new, radar_id: radar.to_param
      expect(response).to be_successful
    end
  end

  describe "POST 'create'" do
    before { allow(radar).to receive(:new_blip).and_return(blip) }

    it "it attempts to save" do
      pending
      expect(blip).to receive(:save)
      post :create, radar_id: radar.to_param, blip: attributes_for(:blip)
    end

    context "with valid params" do
      it "redirects" do
        pending
        allow(blip).to receive(:save).and_return(true)
        post :create, radar_id: radar.to_param, blip: attributes_for(:blip)
        expect(response).to redirect_to(radar)
      end
    end

    context "with invalid params" do
      before do
        allow(blip).to receive(:save).and_return(false)
        post :create, radar_id: radar.id, blip: attributes_for(:blip)
      end

      it "renders the 'new' template" do
        pending
        expect(response).to render_template("new")
      end
    end
  end

  context "DELETE /radars/:radar_id/blips/:id" do
    let(:blip) { mock_model(Blip) }
    before { allow(radar).to receive(:find_blip) { blip } }

    it "destroys the blip" do
      pending
      expect(blip).to receive(:destroy!)
      delete "destroy", radar_id: radar.id, id: blip.id
    end

    it "redirects to the parent radar" do
      pending
      allow(blip).to receive(:destroy!)
      delete "destroy", radar_id: radar.id, id: blip.id
      expect(response).to redirect_to(radar)
    end
  end

  context "PUT /radars/:radar_id/blips/:id" do
    let(:blip) { mock_model(Blip) }
    let(:params) { { notes: "updated notes" } }
    before { allow(radar).to receive(:find_blip) { blip } }

    it "updates the blip" do
      pending
      expect(blip).to receive(:update).with("notes" => "updated notes")
      put "update", radar_id: radar.id, id: blip.id, blip: params
    end

    it "redirects to the parent radar on success" do
      pending
      allow(blip).to receive(:update) { true }
      put "update", radar_id: radar.id, id: blip.id, blip: params
      expect(response).to redirect_to(radar)
    end

    it "redirects to the parent radar on success" do
      pending
      allow(blip).to receive(:update) { true }
      put "update", radar_id: radar.id, id: blip.id, blip: params
      expect(response).to redirect_to(radar)
    end

    it "re-renders the 'edit' template in failure" do
      pending
      allow(blip).to receive(:update) { false }
      put "update", radar_id: radar.id, id: blip.id, blip: { name: "updated name" }
      expect(response).to render_template("edit")
    end
  end
end
