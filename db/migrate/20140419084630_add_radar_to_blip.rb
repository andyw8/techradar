class AddRadarToBlip < ActiveRecord::Migration
  def change
    add_reference :blips, :radar, index: true
  end
end
