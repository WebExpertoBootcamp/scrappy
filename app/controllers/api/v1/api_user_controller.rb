# app/controllers/api/v1/api_user_controller.rb
module Api
  module V1
    class ApiUserController < ApplicationController
      protect_from_forgery with: :null_session
      
      # patch /auth/register
      def register
        #{credenciales : correo, contrasena,
        #coletcion: [{"colchones","gamming","computadoras"}]}

      end


      # POST /auth/register
      def register
        #Debe crear un usuario y devolver un token con att is_admin = false
        #
        #incluir categorias a las que se suscribe
        @user = User.new(user_params)
        if @user.save
          token = JsonWebToken.jwt_encode(user_id: @user.id)
          render json: { token: token, user: @user }, status: :created
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /auth/login
      def login

        render json: { errors: "hola #{params[:email]} tu contraseña es #{params[:password]} #{request.headers["Authorization"]}" }, status: :ok
        # @user = User.find_by(email: params[:email])
        # if @user&.authenticate(params[:password])
        #   token = JsonWebToken.jwt_encode(user_id: @user.id)
        #   render json: { token: token, user: @user }, status: :ok
        # else
        #   render json: { error: 'Invalid email or password' }, status: :unauthorized
        # end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
