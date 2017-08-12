require "rails_helper"

describe UsersController do
  let(:user) { create(:user) }

  describe "GET 'show'" do
    context "as a guest" do
      specify do
        get :show, params: { id: user.id }

        expect(response).to be_successful
      end
    end

    context "as a signed-in user" do
      specify do
        sign_in user

        get :show, params: { id: user.id }

        expect(response).to be_successful
      end
    end

    it "raises a RecordNotFound error for an invaid username" do
      expect do
        get :show, params: { id: "invalid" }
      end.to raise_error ActiveRecord::RecordNotFound, "Couldn't find User"
    end

    context "as an admin" do
      specify do
        admin = create(:admin)
        sign_in admin

        get :show, params: { username: user.username }

        expect(response).to be_successful
      end

      it "finds the right user" do
        admin = create(:admin)
        sign_in admin

        get :show, params: { username: user.username }

        expect(assigns(:user)).to eq user
      end
    end
  end
end
