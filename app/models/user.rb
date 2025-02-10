class User < ApplicationRecord
  has_secure_password
  has_many :conversation_users, dependent: :destroy
  has_many :conversations, through: :conversation_users
  has_many :messages, dependent: :destroy
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
