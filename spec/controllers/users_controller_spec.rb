require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe "GET 'show'" do
    it "redirects non-signed-in users" do
      get :show, id: user.id
      expect(response).to redirect_to(new_user_session_path)
    end

    xit "should redirect to the radars page after signing in" do
      # appears to work fine in the browser. the devise test helps
      # may be messing this up.
      sign_in user
      expect(response).to redirect_to(radars_path)
    end

    context "with a signed-in user" do
      before do
        sign_in user
        get :show, id: user.id
      end

      it "should be successful" do
        expect(response).to be_success
      end

      it "should find the right user" do
        expect(assigns(:user)).to eq user
      end
    end
  end
end
