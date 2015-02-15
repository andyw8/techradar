require "rails_helper"

describe UsersController do
  let(:user) { create(:user) }
  subject { response }

  describe "GET 'show'" do
    context "as a guest" do
      specify do
        get :show, id: user.id
        should be_successful
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
        pending
        expect(assigns(:user)).to eq user
      end
    end
  end
end
