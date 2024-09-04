require 'webmock/rspec'

RSpec.describe KeycloakService do
    before do
        ENV['REALM_ID'] = 'test_realm'
        ENV['CLIENT_ID'] = 'test_client_id'
        ENV['CLIENT_SECRET'] = 'test_client_secret'
        ENV['REDIRECT_URI'] = 'http://localhost:3000/callback'
    end
    
    describe 'get_token' do
        before do
            stub_request(:post, "https://sso-dev.odd.works/realms/#{ENV['REALM_ID']}/protocol/openid-connect/token")
              .with(
                body: {
                  "grant_type" => "authorization_code",
                  "client_id" => ENV['CLIENT_ID'],
                  "client_secret" => ENV['CLIENT_SECRET'],
                  "code" => "test_code",
                  "redirect_uri" => ENV['REDIRECT_URI']
                },
                
              )
              .to_return(body: {access_token: "test_access_token", refresh_token: "test_refresh_token"}.to_json)
          end

        it 'returns tokens' do
            tokens = KeycloakService.get_token('test_code')
            expect(tokens['access_token']).to eq 'test_access_token'
            expect(tokens['refresh_token']).to eq 'test_refresh_token'
        end
    end

    describe 'get_user_info' do
        before do
            stub_request(:get, "https://sso-dev.odd.works/realms/#{ENV['REALM_ID']}/protocol/openid-connect/userinfo")
                .with(
                    headers: {
                        'Authorization' => 'Bearer test_access_token',
                    }
                )
                .to_return(status: 200, body: {email: "test@example.com", sub: "test_sub"}.to_json)
        end

        it 'returns user info' do
            user_info = KeycloakService.get_user_info 'test_access_token' 
            expect(user_info['email']).to eq 'test@example.com' 
            expect(user_info['sub']).to eq 'test_sub'
        end
    end

    describe 'keycloak_logout' do
        before do
            stub_request(:post, "https://sso-dev.odd.works/realms/#{ENV['REALM_ID']}/protocol/openid-connect/logout")
                .with(
                    body: {
                        "client_id" => ENV['CLIENT_ID'],
                        "client_secret" => ENV['CLIENT_SECRET'],
                        "refresh_token" => "test_refresh_token"
                    }
                )
                .to_return(status: 200, body: "", headers: {})
        end

        it 'successfully logs out' do
            response = KeycloakService.keycloak_logout('test_refresh_token')
            expect(response.code).to eq("200")
        end
    end
end