class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.html do
        if !user_signed_in?
          redirect_to_sign_in_page
        else
          redirect_to_home_page
        end
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up,        keys: [:name, :username]
    devise_parameter_sanitizer.permit :account_update, keys: [:name, :username]
  end

  def redirect_to_sign_in_page
    flash[:warning] = "You must sign in first."
    redirect_to signin_url
  end

  def redirect_to_home_page
    flash[:warning] = "You are not authorize to perform this action."
    redirect_to root_url
  end
end
