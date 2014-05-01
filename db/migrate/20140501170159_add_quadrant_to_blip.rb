class AddQuadrantToBlip < ActiveRecord::Migration
  def change
    add_column :blips, :quadrant, :string
  end
end
