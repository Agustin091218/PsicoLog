class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :authenticate_user!

  private

  def current_user
    @current_user ||= User.active.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to sign_in_path, alert: "Please sign in to continue."
    end
  end

  def signed_in?
    current_user.present?
  end

  helper_method :current_user, :signed_in?
end
