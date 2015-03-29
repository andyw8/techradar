require "rails_helper"

describe ApplicationController do
  describe ".after_sign_in_path_for" do
    specify do
      user = stub_current_user
      allow(controller).to receive(:current_user) { user }
      allow(user).to receive(:already_has_topics?) { true }

      result = controller.after_sign_in_path_for(double)

      expect(result).to eq(radars_path)
    end

    specify do
      user = stub_current_user
      allow(user).to receive(:already_has_topics?) { false }

      result = controller.after_sign_in_path_for(double)

      expect(result).to eq(new_bulk_topic_path)
    end

    def stub_current_user
      double(:user).tap do |user|
        allow(controller).to receive(:current_user) { user }
      end
    end
  end
end
