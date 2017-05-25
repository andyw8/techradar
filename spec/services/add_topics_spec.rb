require "rails_helper"

describe AddTopics, "#call" do
  before do
    # When running the specs with `rake spec` they intermittently fail. Seems
    # something isn't been cleared out but I can't figure out what's going on.
    # So using this as a temporary workaround.
    Topic.delete_all
  end

  it "adds no topics if given an empty collection" do
    creator = create(:user)
    described_class.call(topics: [], creator: creator)

    expect(Topic.count).to eq(0)
  end

  it "adds a given list of topics" do
    creator = create(:user)
    described_class.call(topics: ["Topic 1", "Topic 2"], creator: creator)

    expect(Topic.count).to eq(2)
  end

  it "strips whitespace" do
    creator = create(:user)
    described_class.call(topics: ["\t Topic 1 \t "], creator: creator)

    expect(Topic.first.name).to eq("Topic 1")
  end

  it "ignores blank lines" do
    creator = create(:user)
    described_class.call(topics: ["Topic 1", " "], creator: creator)

    expect(Topic.count).to eq(1)
  end
end
