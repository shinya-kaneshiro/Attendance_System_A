class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  $days_of_the_week = %w{日 月 火 水 木 金 土}
  $alphabet = [*'a'..'z']

  # paramsハッシュからユーザーを取得する。
  def set_user
    @user = User.find(params[:id])
  end

  # ページ出力前に1ヶ月分のデータの存在を確認・セットする。
  def set_one_month
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

  # ページ出力前に該当月の申請中レコードの有無を確認する。
  def attendance_confirmation_status_check
    confirmation = AttendanceConfirmation.where(
                                                applicant: params[:id],
                                                status: "申請中",
                                                application_month: @first_day)
    if confirmation.count == 1
      @confirmation = "#{User.find(confirmation[0].manager).name}へ申請中"
    else
      @confirmation = "未"
    end
  end

end
