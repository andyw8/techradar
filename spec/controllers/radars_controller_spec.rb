require "rails_helper"

describe RadarsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }
  let(:params) { attributes_for(:radar) }

  describe "GET 'edit'" do
    it "redirects to login if not signed in" do
      radar = create(:radar, owner: user)

      get "edit", params: { id: radar.uuid, quadrant: "tools" }

      expect(response).to redirect_to(new_user_session_path)
    end

    it "renders the edit page if the user has permission" do
      radar = create(:radar, owner: user)
      sign_in(user)

      get "edit", params: { id: radar.uuid, quadrant: "tools" }

      expect(response).to render_template("radars/edit")
    end

    it "redirects to login if no permission on radar" do
      another_user = create(:user)
      radar = create(:radar, owner: another_user)
      sign_in(user)

      get "edit", params: { id: radar.uuid, quadrant: "tools" }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "GET 'show'" do
    it "redirects to the default quadrant" do
      radar = create(:radar, uuid: "abc123")
      expected_path = radar_quadrant_path(radar, quadrant: "tools")

      get "show", params: { id: radar.uuid }

      expect(response).to redirect_to(expected_path)
    end
  end

  describe "POST 'create'" do
    before do
      sign_in(user)
      stub_current_user_with(user)
    end

    it "creates a radar" do
      radar = mock_model("Radar", save: true)
      allow(user).to receive(:new_radar) { radar }
      post "create", params: { radar: params }
    end

    it "redirects to the newly created radar" do
      post "create", params: { radar: params }
      expect(response).to redirect_to(radar_path(Radar.last))
    end

    it "does not create a radar with invalid params" do
      radar = instance_double("Radar", save: false)
      allow(user).to receive(:new_radar) { radar }
      post "create", params: { radar: params }
      expect(response).to render_template("radars/new")
    end
  end

  describe "DELETE 'destroy'" do
    before do
      sign_in(user)
      stub_current_user_with(user)
    end

    it "destroys the radar" do
      radar = create(:radar, owner: user)
      expect do
        delete "destroy", params: { id: radar.uuid }
      end.to change { user.radars.count }.by(-1)
    end
  end
end
