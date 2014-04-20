class CreateBlips < ActiveRecord::Migration
  def change
    create_table :blips do |t|
      t.string :name

      t.timestamps
    end
  end
end
