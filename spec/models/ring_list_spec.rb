require "rails_helper"

RSpec.describe RingList do
  describe "names with values" do
    it "returns a hash of ring names against values" do
      quadrants = [
        Ring.new("Foo", "foo", 0),
        Ring.new("Bar", "bar", 1)
      ]
      list = described_class.new(quadrants)

      result = list.names_with_values

      expect(result).to eq("Foo" => "foo", "Bar" => "bar")
    end
  end
end
