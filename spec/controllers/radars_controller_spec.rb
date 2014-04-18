require 'spec_helper'

describe RadarsController do
  let(:user) { create(:user) }
  describe "GET 'index'" do
    context "when the user is not signed in" do
      it "redirects to the sign in page" do
        get 'index'
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context "when the user is signed in" do
      before { sign_in(user) }

      it "should be successful" do
        get 'index'
        expect(response).to be_success
      end

      it "lists only radars created by the owner" do
        my_radar = create(:radar, owner: user)
        another_user = create(:user)
        create(:radar, owner: another_user)
        get 'index'
        expect(assigns(:radars)).to eq [my_radar]
      end
    end
  end
end
