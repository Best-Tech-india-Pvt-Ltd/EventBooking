# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  respond_to :json
  skip_before_action :verify_authenticity_token

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.role = "customer"
    resource.save
    
    yield resource if block_given?
    if resource.persisted?
      sign_in(resource_name, resource)
      render json: {
       status: { code: 200, message: "Signed Up sucessfully", data: resource, authorization: "Bearer #{request.env['warden-jwt_auth.token']}"}
     }
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create_event_organizer
    build_resource(sign_up_params)

    resource.role = "event_organizer"

    resource.save
    yield resource if block_given?
    if resource.persisted?
      sign_in(resource_name, resource)
      token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first
      render json: {
       status: { code: 200, message: "Signed Up sucessfully", data: resource, authorization: "Bearer #{token}"}
     }
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # private 

  # def respond_with(resource, options={})
  #  if resource.persisted?
  #    render json: {
  #      status: { code: 200, message: "Signed Up sucessfully", data: resource, authorization: "Bearer #{request.env['warden-jwt_auth.token']}"}
  #    }
  #  else
  #    render json:{
  #      status:{
  #        message: "User could not be created",
  #         errors: resource.errors.full_messages
  #      }, status: :unprocessable_entity
  #    }
  #  end
  # end
end
