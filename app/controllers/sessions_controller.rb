class SessionsController < ApplicationController
  before_action :find_user, only: [:create]
  before_action :authenticate_user, only: [:create]

  def new; end

  def create
    # Log the user in and redirect to the user's show page:
    reset_session
    log_in @user
    redirect_to @user, status: :see_other
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end

  private

  def find_user
    @user = User.find_by(email: params.dig(:session, :email)&.downcase)
    return if @user

    flash.now[:danger] = t("user_not_found")
    render :new, status: :unprocessable_entity
  end

  def authenticate_user
    return if @user.authenticate(params.dig(:session, :password))

    flash.now[:danger] = t("error.invalid_email_password_combination")
    render :new, status: :unprocessable_entity
  end
end
