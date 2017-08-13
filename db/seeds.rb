fail "Users exist" if User.count > 0

admin = User.create!(
  name:                  ENV.fetch('ADMIN_NAME'),
  email:                 ENV.fetch('ADMIN_EMAIL'),
  username:              "admin",
  password:              ENV.fetch('ADMIN_PASSWORD'),
  password_confirmation: ENV.fetch('ADMIN_PASSWORD'),
  admin: true
)
admin.confirm
puts "Admin Created: #{admin.email}"

user = User.create!(
  name:                  "Example User",
  email:                 "user@example.com",
  username:              "example",
  password:              "password",
  password_confirmation: "password",
  admin: false
)
user.confirm
puts "User Created: #{user.email}"
