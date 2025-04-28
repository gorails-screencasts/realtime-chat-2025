class AddLastReadAtToConversationUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :conversation_users, :last_read_at, :datetime

    # We know that a user has definitely read a given conversation up to the point of
    # the last message they wrote in it so we could set the :last_read_at column for
    # for each conversation they are a participant in to that timestamp

    ConversationUser.reset_column_information # Reload the schema information

    ConversationUser.find_each do
      last_message = it.conversation.messages.where(user_id: it.user_id).order(created_at: :desc).first

      if last_message.present?
        it.update_column(:last_read_at, last_message.created_at)
      end
    end
  end
end
