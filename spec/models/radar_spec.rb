require 'spec_helper'

describe Radar do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should belong_to(:owner).class_name('User') }
end
