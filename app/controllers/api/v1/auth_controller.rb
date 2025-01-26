module Api
  module V1
    class AuthController < ApplicationController
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = encode_token({ user_id: user.id })
          render json: { token: token, user: user.slice(:id, :username, :email) }, status: :ok
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end
    end
  end
end
