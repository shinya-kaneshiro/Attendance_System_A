class SessionsController < ApplicationController
  
  def new
    if logged_in?
      flash[:info] = "すでにログインしています。"
      redirect_to user_path(current_user) unless current_user.admin?
      redirect_to users_path(current_user) if current_user.admin?
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "ログインしました。"
      if user.admin?
        redirect_to users_path
      else
        redirect_to user_path user
      end
    else
      flash.now[:danger] = "認証に失敗しました。"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
end
