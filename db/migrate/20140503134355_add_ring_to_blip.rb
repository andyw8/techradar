class AddRingToBlip < ActiveRecord::Migration
  def change
    Blip.delete_all
    add_column :blips, :ring, :string, null: false
  end
end
