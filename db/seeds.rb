#User.create!(email: "example@example.com", password: "password123", password_confirmation: "password123", role: "User")
# Create some users
users = [
  { email: 'admin@admin.com', password: '123456', password_confirmation: '123456', role: 'Admin' },
  { email: 'user@user.com', password: '123456', password_confirmation: '123456', role: 'User' },
  { email: 'user3@example.com', password: '123456', password_confirmation: '123456', role: 'User' }
]

users.each do |user_attributes|
  User.find_or_create_by!(email: user_attributes[:email]) do |user|
    user.password = user_attributes[:password]
    user.password = user_attributes[:password_confirmation]
    user.role = user_attributes[:role]
  end
end