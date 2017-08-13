require "rails_helper"

describe Radars::BlipsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }
  let(:radar) { create(:radar, owner: user) }

  context "guest" do
    describe "GET 'show'" do
      context "for a valid radar and blip" do
        specify do
          radar = create(:radar, owner: user)
          blip = create(:blip, radar: radar)

          get :show, params: { radar_id: radar.to_param, id: blip.to_param }

          expect(controller).to render_template("show")
        end
      end

      context "for an invalid radar" do
        specify do
          expect do
            get :show, params: { radar_id: "99", id: "99" }
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
        get :new, params: { radar_id: radar.to_param }
        expect(response).to be_successful
      end
    end

    describe "POST 'create'" do
      it "created a new blip on the radar" do
        radar = create(:radar, owner: user)
        topic = build_stubbed(:topic)
        attrs = attributes_for(:blip, topic_id: topic.to_param, quadrant: "tools")

        expect do
          post :create, params: { radar_id: radar.to_param, blip: attrs }
        end.to change { radar.blips.count }.by(1)
      end

      it "redirects on success" do
        radar = create(:radar, owner: user)
        topic = build_stubbed(:topic)
        attrs = attributes_for(:blip, topic_id: topic.to_param, quadrant: "tools")

        post :create, params: { radar_id: radar.to_param, blip: attrs }

        expect(response).to redirect_to radar_quadrant_path(radar, quadrant: "tools")
      end

      it "re-renders on failure" do
        radar = create(:radar, owner: user)
        topic = build_stubbed(:topic)
        attrs = attributes_for(:blip, topic_id: topic.to_param, quadrant: "invalid")

        post :create, params: { radar_id: radar.to_param, blip: attrs }
        expect(response).to render_template(:new)
      end
    end

    context "DELETE /radars/:radar_id/blips/:id" do
      let(:blip) { create(:blip) }

      before do
        allow(radar).to receive(:find_blip) { blip }
        allow(user).to receive(:find_radar) { radar }
      end

      it "destroys the blip" do
        allow(blip).to receive(:destroy!)
        delete "destroy", params: { radar_id: radar.id, id: blip.id }
        expect(blip).to have_received(:destroy!)
      end

      it "redirects to the parent radar" do
        allow(blip).to receive(:destroy!)
        delete "destroy", params: { radar_id: radar.id, id: blip.id }
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
        allow(blip).to receive(:update)
        put "update", params: { radar_id: radar.id, id: blip.id, blip: params }
        expect(blip).to have_received(:update).with(
          ActionController::Parameters.new(
            "notes" => "updated notes"
          ).permit(:notes)
        )
      end

      it "redirects to the parent radar on success" do
        allow(blip).to receive(:update) { true }
        put "update", params: { radar_id: radar.id, id: blip.id, blip: params }
        expect(response).to redirect_to(radar)
      end

      it "re-renders the 'edit' template in failure" do
        allow(blip).to receive(:update) { false }
        put "update", params: { radar_id: radar.id, id: blip.id, blip: { quadrant: "x" } }
        expect(response).to render_template("edit")
      end
    end
  end
end
