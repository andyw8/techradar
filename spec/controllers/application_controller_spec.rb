require "rails_helper"

describe ApplicationController do
  describe ".after_sign_in_path_for" do
    context "when the user has already created a topic" do
      it "redirecs to the radars index" do
        stub_progress(already_has_topics: true)

        result = controller.after_sign_in_path_for(double)

        expect(result).to eq(radars_path)
      end
    end

    context "when the user has not already created a topic" do
      it "redirects to the new bulk topic page" do
        stub_progress(already_has_topics: false)

        result = controller.after_sign_in_path_for(double)

        expect(result).to eq(new_bulk_topic_path)
      end
    end

    def stub_current_user
      double(:user).tap do |user|
        allow(controller).to receive(:current_user) { user }
      end
    end

    def stub_progress(already_has_topics:)
      progress = instance_double("Progress", already_has_topics?: already_has_topics)
      allow(Progress).to receive(:new).and_return(progress)
    end
  end
end
