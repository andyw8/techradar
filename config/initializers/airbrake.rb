if Rails.env.production?
  Airbrake.configure do |config|
    config.api_key = ENV['AIRBRAKE_API_KEY'] || fail("Missing AIRBRAKE_API_KEY")
  end
end
