class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates :content, presence: true

  # broadcasts_refreshes
  after_create_commit  -> { broadcast_refresh_later_to(model_name.plural) }
  after_update_commit  -> { broadcast_refresh_later_to(model_name.plural) }
end
