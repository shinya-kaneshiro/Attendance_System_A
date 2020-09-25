class AttendanceConfirmationController < ApplicationController

  def create
    attendance_confirmation = AttendanceConfirmation.new(attendance_confirmation_params)
    user = User.where(id: attendance_confirmation.applicant)
    if attendance_confirmation.save
      flash[:success] = "一ヶ月分の勤怠確認申請を送信しました。"
      redirect_to user_path user[0].id
    else
      flash[:danger] = "申請に失敗しました。"
      redirect_to user_path user[0].id
    end
  end
  
  private
    def attendance_confirmation_params
      params.require(:user).permit(:applicant, :application_month, :manager, :status)
    end
end
