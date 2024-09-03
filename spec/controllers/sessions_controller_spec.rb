require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  before do
    ENV['REALM_ID'] = 'test_realm'
    ENV['CLIENT_ID'] = 'test_client_id'
    ENV['REDIRECT_URI'] = 'http://localhost:3000/callback'
  end
  describe 'GET function lobby' do
    it 'get lobby page' do
      get :lobby
      expect(response).to have_http_status(:ok)
    end

    # it 'hard code session for e2e test' do
    #   get :lobby
    #   expect(session[:user_email]).not_to be_empty
    #   expect(session[:user_id]).not_to be_empty
    #   expect(session[:refresh_token]).not_to be_empty
    # end

    # it 'bypasses login when run e2e tests' do
    #   controller = SessionsController.new
    #   controller.bypasses_keycloak_url
    #   expect(controller.keycloak_url).to eq "/"
    # end
  end

  describe 'GET function callback' do
    context 'when there is a code' do
      before do
        allow(KeycloakService).to receive(:get_token).and_return({'access_token' => 'accessdaratest', 'refresh_token' => 'refreshdaratest'})
        allow(KeycloakService).to receive(:get_user_info).and_return({'email' => 'piangchamas@net.com', 'sub' => 'net'})
      end

      it 'sets session variables and redirects to root path' do
        get :callback, params: { code: 'valid_code' }
        expect(session[:user_email]).to eq 'piangchamas@net.com'
        expect(session[:user_id]).to eq 'net'
        expect(session[:refresh_token]).to eq 'refreshdaratest'
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when there is no code' do
      it 'redirects to login path' do
        get :callback
        expect(response).to redirect_to(lobby_path)
      end
    end
  end

  describe 'GET function logout' do
    it 'clears session and redirects to login path' do
      session[:refresh_token] = 'refreshdaratest'
      expect(KeycloakService).to receive(:keycloak_logout).with('refreshdaratest')
      get :logout
      expect(session[:refresh_token]).to be_nil
      expect(response).to redirect_to(lobby_path)
    end
  end

  # describe 'GET function friendlog_acc_registration' do
  #   it 'renders friendlog account registration page' do
  #     get :friendlog_acc_registration
  #     expect(response).to have_http_status(:ok)
  #   end
  # end
  # describe 'POST function register' do
  #   context 'with validation errors' do
  #     before do
  #       allow(FriendAccRequest).to receive(:validate_registration_params).and_return({email: ['Please enter your email.']})
  #       post :register, params: { firstname: 'net', email: '' }
  #     end

  #     it 'redirects to the registration path' do
  #       expect(response).to redirect_to(friendlog_acc_registration_path)
  #     end

  #     it 'sets flash messages for errors' do
  #       expect(flash[:error_messages]).to include('Please enter your email.')
  #     end
  #   end

  #   context 'with valid parameters' do
  #     before do
  #       allow(FriendAccRequest).to receive(:validate_registration_params).and_return({})
  #       allow(RegisterMailer).to receive_message_chain(:with, :registeration_mailing, :deliver_later)
  #       post :register, params: { firstname: 'net', email: 'piangchamas@net.com' }
  #     end

  #     it 'redirects to the lobby path' do
  #       expect(response).to redirect_to(friendlog_acc_registration_path)
  #     end

  #     it 'sends a registration email' do
  #       expect(RegisterMailer).to have_received(:with).with(hash_including(email: 'piangchamas@net.com'))
  #     end
  #   end
  # end
end

