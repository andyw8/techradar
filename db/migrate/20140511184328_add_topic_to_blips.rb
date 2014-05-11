class AddTopicToBlips < ActiveRecord::Migration
  def change
    add_reference :blips, :topic, index: true
  end
end
