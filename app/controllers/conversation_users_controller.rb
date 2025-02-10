class ConversationUsersController < ApplicationController
  before_action :set_conversation

  def create
    @conversation.conversation_users.where(user: Current.user).first_or_create
    redirect_to @conversation
  end

  def destroy
    @conversation.conversation_users.where(user: Current.user).destroy_all
    redirect_to @conversation
  end

  private

  def set_conversation
    @conversation = Conversation.find(params.expect(:conversation_id))
  end
end
