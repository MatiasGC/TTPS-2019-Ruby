class UsersController < ApplicationController
  
  # POST /usuarios
  def create
    @user = User.create(username: params[:username], password: params[:password])
    if @user.save
      render json: :ok 
    else
      render json: "Ya existe ese nombre se usuario. Pruebe con otro."
    end    
  end
end
