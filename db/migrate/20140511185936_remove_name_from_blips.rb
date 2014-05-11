class RemoveNameFromBlips < ActiveRecord::Migration
  def change
    remove_column :blips, :name, :string
  end
end
