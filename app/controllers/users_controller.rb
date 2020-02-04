class UsersController < ApplicationController
  
  # POST /usuarios
  def create
    @u = params[:username]
    @p = params[:password]
    if @u && @p
      @user = User.create(username: params[:username], password: params[:password])
      if @user.save
        render json: :ok 
      else
        render json: { error: "Ya existe ese nombre se usuario. Probá con otro" }, status: 400 
      end
    else  
      render json: { error: "Debe enviar nombre de usuario y contraseña"}, status: 400      
    end   
  end
end
