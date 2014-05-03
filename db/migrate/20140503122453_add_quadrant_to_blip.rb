class AddQuadrantToBlip < ActiveRecord::Migration
  def up
    Blip.delete_all
    add_column :blips, :quadrant, :string, null: false
  end
end
