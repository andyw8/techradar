RSpec.configure do |config|
  config.before(:example, admin: true) do
    User.create!(name: "Admin", email: "admin@example.com", username: "admin", admin: true, password: "abcd1234")
  end
end
