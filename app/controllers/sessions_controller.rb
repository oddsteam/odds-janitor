class SessionsController < ApplicationController
  def keycloak_url
    @keycloak_url
  end

  def lobby
    @keycloak_url = "https://sso-dev.odd.works/realms/#{ENV["REALM_ID"]}/protocol/openid-connect/auth?client_id=#{ENV["CLIENT_ID"]}&redirect_uri=#{ENV["REDIRECT_URI"]}&response_type=code&scope=openid"
  end

  def callback
    code = params[:code]
    if !code.nil?
      token = KeycloakService::get_token(code)
      userinfo = KeycloakService::get_user_info(token["access_token"])
      if userinfo.nil?
        logout
        return
      end
      refresh_token = token["refresh_token"]
      session[:user_email] = userinfo["email"]
      session[:user_id] = userinfo["sub"]
      session[:refresh_token] = refresh_token
      redirect_to root_path
    else
      redirect_to lobby_path
    end
  end

  def logout
    refresh_token = session[:refresh_token]

    session[:refresh_token] = nil
    session[:user_email] = nil
    session[:user_id] = nil

    KeycloakService.keycloak_logout(refresh_token)
    redirect_to lobby_path
  end
end
