require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe "GET 'show'" do
    it "redirects non-signed-in users" do
      get :show, id: user.id
      expect(response).to redirect_to(new_user_session_path)
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
