class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.create(message_params)
  end

  private

  def set_conversation
    @conversation = Current.user.conversations.find(params.expect(:conversation_id))
  end

  def message_params
    params.expect(message: [ :content ]).with_defaults(user: Current.user)
  end
end
