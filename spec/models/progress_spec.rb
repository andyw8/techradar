require "rails_helper"

RSpec.describe Progress do
  describe "#already_has_topics?" do
    specify do
      user = build_stubbed(:user, created_topics: [])

      progress = described_class.new(user)

      expect(progress.already_has_topics?).to be(false)
    end

    specify do
      topic = build_stubbed(:topic)
      user = build_stubbed(:user, created_topics: [topic])

      progress = described_class.new(user)

      expect(progress.already_has_topics?).to be(true)
    end
  end
end
