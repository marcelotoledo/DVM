# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  protected
  
  def logged_in?
    unless session[:user_id]
      flash.alert = "Você precisa estar logado"
      redirect_to root_path
      return false
    else
      return true
    end
  end

  def has_permission_to_be_here?
    company_id = User.find(session[:user_id]).company_id
    
    if company_id != 1
      redirect_to '/denied'
    end
  end

  private
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
