class TwitterProfileImage
  def self.call(username)
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV.fetch("TWITTER_API_KEY")
      config.consumer_secret     = ENV.fetch("TWITTER_API_SECRET")
    end
    user = client.user(username)
    user.profile_image_url.to_s.gsub("_normal", "")
  end
end

