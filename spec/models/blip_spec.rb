require 'spec_helper'

describe Blip do
  it { should belong_to(:radar) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:quadrant) }
  it { should ensure_inclusion_of(:quadrant).in_array(Blip::QUADRANTS) }
  it { should validate_presence_of(:radar) }
end
