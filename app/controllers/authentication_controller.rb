# app/controllers/authentication_controller.rb
class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate

  # return auth token once user is authenticated
  def authenticate
    userdata =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    json_response(userdata)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
