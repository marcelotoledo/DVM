class SessionsController < ApplicationController
  layout "session"
  
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to vouchers_path
    else
      flash.now.alert = "Email ou senha incorreta"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Deslogado!"
  end
end
