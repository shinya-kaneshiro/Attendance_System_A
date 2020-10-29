class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper, AttendanceConfirmationHelper

  $days_of_the_week = %w{日 月 火 水 木 金 土}
  $alphabet = [*'a'..'z']
  $status_select = ApplicationStatus.all

  # paramsハッシュからユーザーを取得する。
  def set_user
    @user = User.find(params[:id])
  end

  # ページ出力前に1ヶ月分のデータの存在を確認・セットする。
  def set_one_month
    if params[:readonly_flag] == "1"
      @first_day = params[:date].to_date
      @last_day = @first_day.end_of_month
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    else
      set_one_month_default
    end
  end

  # ページ出力前に1ヶ月分のデータの存在を確認・セットする（raedonly_flagが"1"でない場合）。
  def set_one_month_default
    @first_day = params[:date].nil? ?
    Date.current.beginning_of_month : params[:date].to_date
    @last_day = @first_day.end_of_month
    one_month = [*@first_day..@last_day]
  
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
  
    unless one_month.count == @attendances.count
      ActiveRecord::Base.transaction do
        one_month.each { |day| @user.attendances.create!(worked_on: day) }
      end
      @attendances = @user.attendances.where(worked_on: @first_day..@last_day).order(:worked_on)
    end

  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "ページ情報の取得に失敗しました、再アクセスしてください。"
    redirect_to root_url
  end
  
  # 上長選択のプルダウン用
  def set_superiors
    if current_user.superior?
      superiors = User.where(superior: true)
      @superiors = superiors.where.not(id: current_user.id)
    else
      @superiors = User.where(superior: true)
    end
  end
  
  # ログイン済みのユーザーか確認し、未ログインならログインページへ遷移させる。
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end

  # アクセスしたユーザーが現在ログインしているユーザーか確認する。
  def correct_user
    if params[:user_id].nil?
      @user = User.find(params[:id])
    else
      @user = User.find(params[:user_id])
    end
    unless current_user?(@user)
      flash[:danger] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
  end

  # 上長ユーザ権限保有者、またはログインユーザー本人のみアクセスを許可する。
  def superior_or_correct_user
    if params[:user_id].nil?
      @user = User.find(params[:id])
    else
      @user = User.find(params[:user_id])
    end
    unless current_user?(@user) || current_user.superior?
      flash[:danger] = "アクセス権限がありません。"
      redirect_to(root_url)
    end
    if current_user.superior? && params[:readonly_flag].nil?
      unless @user == current_user
        flash[:danger] = "申請者の勤怠表示画面はモーダルから読み取り専用でアクセスしてください）"
        redirect_to user_url current_user
      end
    end
  end

  # 管理者権限を保有していない場合、アクセスを拒否する。
  def admin_user
    unless current_user.admin?
      flash[:danger] = "アクセス権限がありません。"
      redirect_to root_url
    end
  end
end
