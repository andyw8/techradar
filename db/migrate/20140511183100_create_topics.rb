class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :topics, :slug, unique: true
  end
end
