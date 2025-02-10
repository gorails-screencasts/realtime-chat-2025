class CreateConversationUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :conversation_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :conversation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
