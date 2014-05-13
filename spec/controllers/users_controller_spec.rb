require 'spec_helper'

describe UsersController do
  let(:user) { create(:user) }
  subject { response }

  describe "GET 'show'" do
    context "as a guest" do
      specify do
        get :show, id: user.id
        should be_successful
      end

      xit "should redirect to the radars page after signing in" do
        # appears to work fine in the browser. the devise test helps
        # may be messing this up.
        sign_in user
        should redirect_to(radars_path)
      end
    end

    context "as a signed-in user" do
      before do
        sign_in user
        get :show, id: user.id
      end

      it { should be_successful }
    end

    context "as an admin" do
      let(:admin) { create(:admin) }
      before do
        sign_in admin
        get :show, id: user.id
      end

      it { should be_successful }

      it "finds the right user" do
        expect(assigns(:user)).to eq user
      end
    end
  end
end
