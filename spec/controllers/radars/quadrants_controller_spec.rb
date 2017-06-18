require "rails_helper"

describe Radars::QuadrantsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }

  describe "GET 'show'" do
    it "renders the specified quadrant" do
      sign_in(user)
      stub_current_user_with(user)
      radar = create(:radar, uuid: "abc123", owner: user)

      get "show", params: { id: radar.uuid, quadrant: "tools" }

      expect(response).to render_template("radars/show")
    end
  end
end
