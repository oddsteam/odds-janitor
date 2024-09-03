class KeycloakService
  require "net/http"

  # "get token" function is one that gonna start API request in order to obtain the tokens from keycloak server after login successfully.
  def self.get_token(code)
    uri_token = URI.parse("https://sso-dev.odd.works/realms/#{ENV["REALM_ID"]}/protocol/openid-connect/token")
    token_request = Net::HTTP::Post.new(uri_token)
    token_request.set_form_data(
      "grant_type" => "authorization_code",
      "client_id" => ENV["CLIENT_ID"],
      "client_secret" => ENV["CLIENT_SECRET"],
      "code" => code,
      "redirect_uri" => ENV["REDIRECT_URI"],
    )
    http = Net::HTTP::start(uri_token.host, uri_token.port, use_ssl: true)
    response = http.request(token_request)
    # puts response
    # if response.messagae
    tokens = JSON.parse(response.body)
    return tokens
  end

  def self.get_user_info(access_token)
    uri_info = URI.parse("https://sso-dev.odd.works/realms/#{ENV["REALM_ID"]}/protocol/openid-connect/userinfo")
    userInfo_request = Net::HTTP::Get.new(uri_info)
    userInfo_request["Authorization"] = "Bearer #{access_token}"
    http = Net::HTTP::start(uri_info.host, uri_info.port, use_ssl: true)
    response = http.request(userInfo_request)
    begin
      userInfo = JSON.parse(response.body)
    rescue JSON::ParserError => e
      Rails.logger.error("Failed to parse userinfo response: #{e.message}")
      return nil
    end
    return userInfo
  end

  def self.keycloak_logout(refresh_token)
    uri_logout = URI.parse("https://sso-dev.odd.works/realms/#{ENV["REALM_ID"]}/protocol/openid-connect/logout")
    logout_request = Net::HTTP::Post.new(uri_logout)
    logout_request.set_form_data(
      "client_id" => ENV["CLIENT_ID"],
      "client_secret" => ENV["CLIENT_SECRET"],
      "refresh_token" => refresh_token,
    )
    http = Net::HTTP.start(uri_logout.host, uri_logout.port, use_ssl: true)
    response = http.request(logout_request)
    return response
  end
end
