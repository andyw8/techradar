# http://manuelvanrijn.nl/sidekiq-heroku-redis-calc/

require "sidekiq"

Sidekiq.configure_client do |config|
  config.redis = { size: 1 }
end
