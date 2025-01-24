class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    messages = current_user.received_messages.or(current_user.sent_messages)
    render json: messages, status: :ok
  end

  def create
    message = current_user.sent_messages.build(message_params)
    if message.save
      render json: { message: 'Message sent successfully' }, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    message = Message.find_by(id: params[:id], sender: current_user)
    if message&.destroy
      render json: { message: 'Message deleted successfully' }, status: :ok
    else
      render json: { error: 'Message not found or not authorized' }, status: :not_found
    end
  end

  private

  def message_params
    params.permit(:receiver_id, :content)
  end
end
