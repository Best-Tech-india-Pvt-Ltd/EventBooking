# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json
  skip_before_action :verify_authenticity_token
  
  private 

  def respond_with(resource, options = {})
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.', data: resource, authorization: "Bearer #{request.env['warden-jwt_auth.token']}"
      }
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user 
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: { 
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
