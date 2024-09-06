class ApplicationController < ActionController::Base
  def isLogin
    redirect_to lobby_path if session[:refresh_token].nil?
  end
end
