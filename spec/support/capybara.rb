require "selenium/webdriver"
require "capybara/email/rspec"

Capybara.asset_host = "techradar.dev"

# https://robots.thoughtbot.com/headless-feature-specs-with-chrome

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new app, browser: :chrome,
                                      desired_capabilities: capabilities
end

Capybara.javascript_driver = :chrome
