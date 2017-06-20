class MessagesController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def index
    @messages = Message.all
    @new_message = current_user.messages.build
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.save
    respond_with { @message }
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end