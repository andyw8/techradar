class AddCreatorToTopics < ActiveRecord::Migration
  def change
    add_reference :topics, :creator, index: true
  end
end
