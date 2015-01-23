class AddTwitterProfileImageToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :twitter_profile_image, :string
  end
end
