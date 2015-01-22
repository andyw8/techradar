class AddTwitterUsernameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :twitter_username, :string
  end
end
