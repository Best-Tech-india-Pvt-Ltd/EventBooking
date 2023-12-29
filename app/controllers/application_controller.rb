class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render :json => {'errors' => ['You are not authorized to perform this action.']}, :status => 403
  end
end
