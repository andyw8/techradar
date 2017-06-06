require "rails_helper"

describe BulkTopic do
  it "splits the topics list by line break" do
    creator = instance_double("User")
    allow(AddTopics).to receive(:call)

    bulk_topic = described_class.new(
      topics: "topic 1\ntopic 2",
      creator: creator
    )
    bulk_topic.save

    expect(AddTopics).to have_received(:call).with(
      topics: ["topic 1", "topic 2"],
      creator: creator
    )
  end
end
