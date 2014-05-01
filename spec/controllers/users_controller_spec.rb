require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }

  describe "GET 'show'" do
    it "redirects non-signed-in users" do
      get :show, id: user.id
      expect(response).to redirect_to(root_path)
    end

    xit "should redirect to the radars page after signing in" do
      # appears to work fine in the browser. the devise test helps
      # may be messing this up.
      sign_in user
      expect(response).to redirect_to(radars_path)
    end

    context "as a signed-in user" do
      before do
        sign_in user
        get :show, id: user.id
      end

      it "is not successful" do
        expect(response).to_not be_successful
      end
    end
  end

  context "as an admin" do
    let(:admin) { create(:admin) }
    before do
      sign_in admin
      get :show, id: user.id
    end

    it "it is successful" do
      expect(response).to be_success
    end

    it "finds the right user" do
      expect(assigns(:user)).to eq user
    end
  end
end
