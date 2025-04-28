class Conversation < ApplicationRecord
  has_many :conversation_users, dependent: :destroy
  has_many :users, through: :conversation_users
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  def participant?(user)
    users.include?(user)
  end

  def has_unread_messages_for?(user)
    if participant?(user)
      conversation_user = conversation_users.find_by(user: user)
      messages.where("created_at > ?", conversation_user.last_read_at).exists?
    end
  end
end
