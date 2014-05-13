require 'spec_helper'

describe Topic do
  it { should validate_presence_of(:name) }
  # TODO I don't think the case_insensitive check is working
  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should validate_presence_of(:slug) }
  it { should validate_uniqueness_of(:slug) }

  it { should have_many(:blips) }
end
