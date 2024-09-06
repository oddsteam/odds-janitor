class ApplicationController < ActionController::Base
  def isLogin
    redirect_to "https://sso-dev.odd.works/realms/#{ENV["REALM_ID"]}/protocol/openid-connect/auth?client_id=#{ENV["CLIENT_ID"]}&redirect_uri=#{ENV["REDIRECT_URI"]}&response_type=code&scope=openid", allow_other_host: true if session[:refresh_token].nil?
  end
end
