require "rails_helper"

describe UsersController do
  let(:user) { create(:user) }
  subject { response }

  describe "GET 'show'" do
    context "as a guest" do
      specify do
        get :show, id: user.id

        expect(response).to be_successful
      end
    end

    context "as a signed-in user" do
      before do
        sign_in user

        get :show, id: user.id

        expect(response).to be_successful
      end
    end

    context "as an admin" do
      specify do
        admin = create(:admin)
        sign_in admin

        get :show, username: user.username

        expect(response).to be_successful
      end

      it "finds the right user" do
        admin = create(:admin)
        sign_in admin

        get :show, username: user.username

        expect(assigns(:user)).to eq user
      end
    end
  end
end
