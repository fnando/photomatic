# frozen_string_literal: true

class LoginController < ApplicationController
  before_action :redirect_logged_user, except: %i[destroy]
  before_action :redirect_check_inbox_without_email, only: %i[check_inbox]

  def new
    @login_form = LoginForm.new
  end

  def create
    @login_form = LoginForm.new(login_params)

    LogIn.call(@login_form) do |action|
      action.on(:success) do
        session[:login_email] = @login_form.email
        redirect_to check_inbox_path
      end

      action.on(:error) do
        render :new
      end
    end
  end

  def destroy
    reset_session
    redirect_to home_path
  end

  def check_inbox
  end

  def verify_email
    VerifyEmail.call(
      signed_url: request.original_url,
      code: params[:code],
      email: params[:email]
    ) do |action|
      action.on(:success) do |user|
        SimpleAuth::Session.create(
          scope: "user",
          session:,
          record: user
        )

        redirect_to return_to(root_path)
      end

      action.on(:error) do
        redirect_to login_path, alert: t("flash.login.verify_email.alert")
      end
    end
  end

  private def login_params
    params.require(:login).permit(:email)
  end

  private def redirect_check_inbox_without_email
    redirect_to login_path unless session[:login_email]
  end
end
