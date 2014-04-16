class CreateRadars < ActiveRecord::Migration
  def change
    create_table :radars do |t|
      t.string :name

      t.timestamps
    end
  end
end
