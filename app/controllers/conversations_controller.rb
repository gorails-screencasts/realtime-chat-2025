class ConversationsController < ApplicationController
  before_action :gather_all_conversations, only: [ :index, :show ]

  def index
  end

  def show
    @conversation = Conversation.includes(:messages).find(params.expect(:id))
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      redirect_to @conversation, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def conversation_params
    params.expect(conversation: [ :name ])
  end

  def gather_all_conversations
    @conversations = Conversation.all
  end
end
