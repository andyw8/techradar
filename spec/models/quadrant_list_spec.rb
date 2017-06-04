require "rails_helper"

RSpec.describe QuadrantList do
  describe "names with values" do
    it "returns a hash of quadrants names against values" do
      quadrants = [
        Quadrant.new("Foo", "foo", "nw"),
        Quadrant.new("Bar", "bar", "ne")
      ]
      list = described_class.new(quadrants)

      result = list.names_with_values

      expect(result).to eq("Foo" => "foo", "Bar" => "bar")
    end
  end
end
