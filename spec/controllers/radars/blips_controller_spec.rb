require "rails_helper"

describe Radars::BlipsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }
  let(:radar) { create(:radar, owner: user) }
  let(:blip) { double("Blip") }

  context "guest" do
    describe "GET 'show'" do
      context "for a valid radar and blip" do
        specify do
          radar = create(:radar, owner: user)
          blip = create(:blip, radar: radar)

          get :show, radar_id: radar.to_param, id: blip.to_param

          expect(controller).to render_template("show")
        end
      end

      context "for an invalid radar" do
        specify do
          expect do
            get :show, radar_id: "99", id: "99"
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  context "signed in" do
    before do
      sign_in(user)
      stub_current_user_with(user)
      allow(Radar).to receive(:find).and_return(radar)
    end

    describe "GET 'new'" do
      specify do
        get :new, radar_id: radar.to_param
        expect(response).to be_successful
      end
    end

    describe "POST 'create'" do
      it "delegates to radar for new" do
        allow(user).to receive(:find_radar) { radar }
        topic = double(:topic)
        attrs = attributes_for(:blip, topic_id: topic.to_param)
        blip = double("blip", quadrant: "tools", save: true)
        allow(radar).to receive(:new_blip) { blip }

        post :create, radar_id: radar.to_param, blip: attrs

        expect(radar).to have_received(:new_blip).with(
          topic_id: topic.to_param,
          quadrant: "tools",
          ring: "adopt"
        )
      end

      it "redirects on success" do
        allow(user).to receive(:find_radar) { radar }
        attrs = attributes_for(:blip, topic_id: 1)
        blip = double("blip", quadrant: "tools", save: true)
        allow(radar).to receive(:new_blip) { blip }

        post :create, radar_id: radar.to_param, blip: attrs

        expected_path = radar_quadrant_path(radar, quadrant: "tools")
        expect(response).to redirect_to(expected_path)
      end

      it "re-renders on failure" do
        allow(user).to receive(:find_radar) { radar }
        attrs = attributes_for(:blip, topic_id: 1)
        blip = double("blip", quadrant: "tools", save: false)
        allow(radar).to receive(:new_blip) { blip }

        post :create, radar_id: radar.to_param, blip: attrs

        expect(response).to render_template("new")
      end
    end

    context "DELETE /radars/:radar_id/blips/:id" do
      let(:blip) { mock_model(Blip) }
      before do
        allow(radar).to receive(:find_blip) { blip }
        allow(user).to receive(:find_radar) { radar }
      end

      it "destroys the blip" do
        expect(blip).to receive(:destroy!)
        delete "destroy", radar_id: radar.id, id: blip.id
      end

      it "redirects to the parent radar" do
        allow(blip).to receive(:destroy!)
        delete "destroy", radar_id: radar.id, id: blip.id
        expect(response).to redirect_to(radar)
      end
    end

    context "PUT /radars/:radar_id/blips/:id" do
      let(:blip) { mock_model(Blip) }
      let(:params) { { notes: "updated notes" } }
      before do
        allow(radar).to receive(:find_blip) { blip }
        allow(user).to receive(:find_radar) { radar }
      end

      it "updates the blip" do
        expect(blip).to receive(:update).with("notes" => "updated notes")
        put "update", radar_id: radar.id, id: blip.id, blip: params
      end

      it "redirects to the parent radar on success" do
        allow(blip).to receive(:update) { true }
        put "update", radar_id: radar.id, id: blip.id, blip: params
        expect(response).to redirect_to(radar)
      end

      it "redirects to the parent radar on success" do
        allow(blip).to receive(:update) { true }
        put "update", radar_id: radar.id, id: blip.id, blip: params
        expect(response).to redirect_to(radar)
      end

      it "re-renders the 'edit' template in failure" do
        allow(blip).to receive(:update) { false }
        put "update", radar_id: radar.id, id: blip.id, blip: { quadrant: "x" }
        expect(response).to render_template("edit")
      end
    end
  end
end
