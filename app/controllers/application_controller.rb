# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def after_sign_in_path_for(_)
    request.env['omniauth.origin'] || admin_offers_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def set_locale
    I18n.locale = session[:locale] if session[:locale]
  end
end
