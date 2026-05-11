class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    redirect_to root_path if signed_in?
  end

  def create
    user = User.active.find_by(email: session_params[:email]&.downcase)

    if user&.authenticate(session_params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to session.delete(:return_to) || root_path, notice: "Signed in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
      redirect_to sign_in_path, notice: "Signed out."
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
