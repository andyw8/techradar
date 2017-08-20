require "rails_helper"

describe ApplicationController do
  describe ".after_sign_in_path_for" do
    context "when the user has already created a topic" do
      it "redirecs to the radars index" do
        user = stub_current_user
        allow(controller).to receive(:current_user) { user }
        progress = instance_double("Progress", already_has_topics?: true)
        allow(Progress).to receive(:new).and_return(progress)

        result = controller.after_sign_in_path_for(double)

        expect(result).to eq(radars_path)
      end
    end

    context "when the user has not already created a topic" do
      it "redirects to the new bulk topic page" do
        progress = instance_double("Progress", already_has_topics?: false)
        allow(Progress).to receive(:new).and_return(progress)

        result = controller.after_sign_in_path_for(double)

        expect(result).to eq(new_bulk_topic_path)
      end
    end

    def stub_current_user
      double(:user).tap do |user|
        allow(controller).to receive(:current_user) { user }
      end
    end
  end
end
