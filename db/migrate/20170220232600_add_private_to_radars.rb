class AddPrivateToRadars < ActiveRecord::Migration[5.0]
  def change
    add_column :radars, :private, :boolean, default: false
  end
end
