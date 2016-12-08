class Api::V1::UsersController < ApplicationController

  def index
    #code
  end


	def create
		if !params[:auth]
			render json: { error: "No encontramos el parámetro Auth" }
		else
		  @user = User.from_omniauth(params[:auth])
			@token = @user.tokens.create(user: @user)
			render "api/v1/users/show"
		end
	end


end
