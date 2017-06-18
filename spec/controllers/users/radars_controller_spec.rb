require "rails_helper"

describe Users::RadarsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }

  describe "GET 'index'" do
    context "when the user is not signed in" do
      it "lists all radars" do
        sign_in(user)
        stub_current_user_with(user)
        radars = [instance_double("Radar")]
        allow(user).to receive(:radars) { radars }

        get "index", params: { user_username: user.username }

        expect(response).to render_template("users/radars/index")
      end
    end
  end
end
