require "rails_helper"

RSpec.describe Ability do
  context "a user" do
    it "is able to create a radar" do
      user = build(:user)
      ability = described_class.new(user)

      result = ability.can?(:create, Radar)

      expect(result).to be(true)
    end

    it "is able to edit a radar they own" do
      user = build(:user)
      radar = build(:radar, owner: user)
      ability = described_class.new(user)

      result = ability.can?(:edit, radar)

      expect(result).to be(true)
    end

    it "is unable to edit a radar they do not own" do
      user = build(:user)
      radar = build(:radar, owner: another_user)
      ability = described_class.new(user)

      result = ability.can?(:edit, radar)

      expect(result).to be(false)
    end

    it "is able to delete a radar they own" do
      user = build(:user)
      radar = build(:radar, owner: user)
      ability = described_class.new(user)

      result = ability.can?(:delete, radar)

      expect(result).to be(true)
    end

    it "is unable to delete a radar they do not own" do
      user = build(:user)
      radar = build(:radar, owner: another_user)
      ability = described_class.new(user)

      result = ability.can?(:delete, radar)

      expect(result).to be(false)
    end

    it "is able to create a blip on a radar they own" do
      user = build(:user)
      radar = build(:radar, owner: user)
      blip = build(:blip, radar: radar)
      ability = described_class.new(user)

      result = ability.can?(:create, blip)

      expect(result).to be(true)
    end

    it "is unable able to create a blip on a radar they do not own" do
      user = build(:user)
      radar = build(:radar, owner: another_user)
      blip = build(:blip, radar: radar)
      ability = described_class.new(user)

      result = ability.can?(:create, blip)

      expect(result).to be(false)
    end

    it "is able to delete a blip from a radar they own" do
      user = build(:user)
      radar = build(:radar, owner: user)
      blip = build(:blip, radar: radar)
      ability = described_class.new(user)

      result = ability.can?(:delete, blip)

      expect(result).to be(true)
    end

    it "is unable able to delete a blip from a radar they do not own" do
      user = build(:user)
      radar = build(:radar, owner: another_user)
      blip = build(:blip, radar: radar)
      ability = described_class.new(user)

      result = ability.can?(:delete, blip)

      expect(result).to be(false)
    end

    let(:another_user) { build(:user) }
  end
end
