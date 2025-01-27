module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_user!

      def index
        messages = Message.visible_to(current_user).includes(:sender, :receiver)

        render json: messages.map { |message|
          {
            id: message.id,
            sender_id: message.sender_id,
            receiver_id: message.receiver_id,
            content: message.content,
            created_at: message.created_at,
            sender_username: message.sender_username,
            receiver_username: message.receiver_username,
            created_at: message.created_at.strftime("%Y-%m-%d %H:%M:%S")
          }
        }, status: :ok
      end

      def create
        receiver = User.find_by(email: params[:receiver_email])

        if receiver.nil?
          render json: { errors: [ "Receiver email not found" ] }, status: :unprocessable_entity
          return
        end

        if receiver.id == current_user.id
          render json: { errors: [ "You cannot send a message to yourself" ] }, status: :unprocessable_entity
          return
        end

        message = current_user.sent_messages.build(
          content: params[:content],
          receiver_id: receiver.id
        )

        if message.save
          render json: { message: "Message sent successfully" }, status: :created
        else
          render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        message = Message.find(params[:id])

        if message.sender == current_user
          message.update(deleted_by_sender: true)
        elsif message.receiver == current_user
          message.update(deleted_by_receiver: true)
        else
          render json: { error: "You are not authorized to delete this message." }, status: :unauthorized
          return
        end

        render json: { message: "Message deleted successfully." }, status: :ok
      end

      private

      def message_params
        params.permit(:receiver_email, :content)
      end
    end
  end
end
