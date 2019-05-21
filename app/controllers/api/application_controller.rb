class Api::ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protect_from_forgery with: :null_session

  before_action :authenticate

  protected

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @usert = User.find_by(auth_token: token)
    end
  end

  def request_http_token_authentication(realm = 'Application', msg = nil)
    render json: {error: 'Token incorrecto'}, status: :unauthorized
  end

  def current_user
    @user
  end
end
