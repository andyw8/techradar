require 'spec_helper'

describe RadarsController do
  include StubCurrentUserHelper

  let(:user) { create(:user) }
  let(:params) { attributes_for(:radar) }

  describe "GET 'index'" do
    context "when the user is not signed in" do
      it "redirects to the sign in page" do
        get 'index'
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when the user is signed in" do
      before { sign_in(user) }

      context do
        before { get 'index' }
        specify { expect(response).to be_success }
        specify { expect(response).to render_template('radars/index') }
      end

      it "lists only radars created by the owner" do # should this be here?
        my_radar = create(:radar, owner: user)
        another_user = create(:user)
        create(:radar, owner: another_user)
        get 'index'
        expect(assigns(:radars)).to eq [my_radar]
      end
    end
  end

  describe "POST 'create'" do
    before { sign_in(user); stub_current_user_with(user) }

    it "creates a radar" do
      radar = double('Radar', save: true)
      user.stub(new_radar: radar)
      post 'create', radar: params
    end

    it "redirects" do
      post 'create', radar: params
      expect(response).to redirect_to(radars_path)
    end

    it "does not create a radar with invalid params" do
      radar = double('Radar', save: false)
      user.stub(new_radar: radar)
      post 'create', radar: params
      expect(response).to render_template('radars/new')
    end
  end

  describe "DELETE 'destroy'" do
    before { sign_in(user); stub_current_user_with(user) }

    it "destroys the radar" do
      radar = build_stubbed(:radar)
      expect(user).to receive(:find_radar).with(radar.id.to_s).and_return(radar)
      expect(radar).to receive(:destroy!)
      delete 'destroy', id: radar.id
    end
  end
end
