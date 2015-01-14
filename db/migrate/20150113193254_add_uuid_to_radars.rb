class AddUuidToRadars < ActiveRecord::Migration
  def change
    add_column :radars, :uuid, :string, require: true
  end
end
