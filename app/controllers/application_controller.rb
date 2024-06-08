class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation, :family_id]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: [:name]
    devise_parameter_sanitizer.permit(:invite) { |u| u.permit(:email, :name, :invited_by_family_id) }
    devise_parameter_sanitizer.permit(:accept_invitation) { |u| u.permit(:password, :password_confirmation, :invitation_token, :name, :invited_by_family_id) }
  end
end
