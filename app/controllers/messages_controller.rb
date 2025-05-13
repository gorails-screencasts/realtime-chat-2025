class MessagesController < ApplicationController
  before_action :set_conversation
  before_action :set_message, only: [ :edit, :update ]

  def create
    @message = @conversation.messages.create(message_params)
    redirect_to @conversation
  end

  def edit
  end

  def update
    @message.update(message_params)
    redirect_to @conversation
  end

  private

  def set_conversation
    @conversation = Current.user.conversations.find(params.expect(:conversation_id))
  end

  def set_message
    @message = @conversation.messages.find(params.expect(:id))
  end

  def message_params
    params.expect(message: [ :content ]).with_defaults(user: Current.user)
  end
end
