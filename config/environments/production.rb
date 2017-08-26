Rails.application.configure do
  config.action_controller.perform_caching = true
  config.active_record.dump_schema_after_migration = false
  config.active_support.deprecation = :notify

  config.assets.compile = false
  config.assets.digest = true
  config.assets.js_compressor = :uglifier

  config.cache_classes = true
  config.consider_all_requests_local = false
  config.eager_load = true
  config.i18n.fallbacks = true
  config.log_level = :debug
  config.serve_static_files = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.action_mailer.default_url_options = { host: "techradar.io" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.smtp_settings = {
    address: "smtp.sendgrid.net",
    port: 587,
    domain: ENV["DOMAIN_NAME"],
    authentication: "plain",
    user_name: ENV["SENDGRID_USERNAME"],
    password: ENV["SENDGRID_PASSWORD"]
  }

  config.log_formatter = ::Logger::Formatter.new

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
end
