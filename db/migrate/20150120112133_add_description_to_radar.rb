class AddDescriptionToRadar < ActiveRecord::Migration
  def change
    add_column :radars, :description, :text
  end
end
