class AuthenticationController < ApplicationController

    def login
        @user = User.find(username: params[:username])
        
        if @user

            if @user.authenticate(params[:password])

                payload = {user_id: @user.id}
                secret = Rails.application.secrets.secret_key_base

                token = JWT.encode(payload, secret)

                render json: {token: token}


            else
                render json: "nice try asshole", status: :unathorized
            end

        else
            render json: "nice try asshole!", status: :unauthorized
        end

    end
end