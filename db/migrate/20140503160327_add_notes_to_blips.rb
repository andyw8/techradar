class AddNotesToBlips < ActiveRecord::Migration
  def change
    add_column :blips, :notes, :text
  end
end
