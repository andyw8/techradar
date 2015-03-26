require "rails_helper"

describe AddTopics, "#call" do
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

  it "skips existing topics" do
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
