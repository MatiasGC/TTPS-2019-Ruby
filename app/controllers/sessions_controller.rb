class SessionsController < ApplicationController
	def createSession

		@user = User.find_by(username: params[:u], password: params[:p])
		if @user.present?
			generate_token(@user)
			render json: @user
		else
			render json: { error: "Nombre de usuario o password incorrecto" }, status: 404
		end

	end

	private
	def generate_token(a_user) 
		a_user.update(token: Devise.friendly_token, token_created_at: Time.now)
	end
end
