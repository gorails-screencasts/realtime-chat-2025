class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true

  broadcasts_refreshes_to ->(message) { [ message.conversation, :messages ] }
end
