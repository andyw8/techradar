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

      context do
        before { get 'index' }
        specify { expect(response).to be_success }
        specify { expect(response).to render_template('radars/index') }
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

  describe "POST 'create'" do
    before { sign_in(user) }
    it do
      params = double
      post 'create', radar: params
      expect(Radar).to_receive(:create).with(radar: params)
    end
  end

  describe "DELETE 'destroy'" do
    before { sign_in(user) }
    it "destroys the radar" do
      radar = build_stubbed(:radar)
      User.any_instance.stub(find_radar: radar)
      radar.should_receive(:destroy!)
      delete 'destroy', id: radar.id
    end
  end
end
