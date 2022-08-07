# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    admin_homes_top_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
