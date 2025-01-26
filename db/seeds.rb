# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# For testing pupose
# Create users
User.create!(username: "User1", email: "user1@example.com", password: "password123")
User.create!(username: "User2", email: "user2@example.com", password: "password123")
User.create!(username: "User3", email: "user3@example.com", password: "password123")
User.create!(username: "User4", email: "user4@example.com", password: "password123")

# Send messages between users
user1 = User.find_by(email: "user1@example.com")
user2 = User.find_by(email: "user2@example.com")
user3 = User.find_by(email: "user3@example.com")

# User1 sends to User2
user1.sent_messages.create!(receiver: user2, content: "Hello User2!")

# User2 sends to User1
user2.sent_messages.create!(receiver: user1, content: "Hi User1!")

# User3 sends to User1
user3.sent_messages.create!(receiver: user1, content: "Hi User1, it's User3!")
