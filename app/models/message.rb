class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true

  broadcasts_to ->(message) { [ message.conversation, :messages ] }
end
