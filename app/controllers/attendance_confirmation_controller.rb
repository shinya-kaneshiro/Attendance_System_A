class AttendanceConfirmationController < ApplicationController
  before_action :set_user, only: [:create, :confirmation_update]
  
  $status_select = ApplicationStatus.all

  def create
    attendance_confirmation = AttendanceConfirmation.new(attendance_confirmation_params)
    if attendance_confirmation.save
      flash[:success] = "一ヶ月分の勤怠確認申請を送信しました。"
      redirect_to user_path @user
    else
      flash[:danger] = "申請に失敗しました。"
      redirect_to user_path @user
    end
  end
  
  def confirmation
    @confirmations = AttendanceConfirmation.where(superior_id: params[:id])
    @users = User.all
  end
  
  def confirmation_update
    ActiveRecord::Base.transaction do
      confirmation_only_params.each do |id, item|
        if item[:check_box] == "1"
          confirmation = AttendanceConfirmation.find(id)
          confirmation.update_attributes!(item)
          confirmation.check_box = false
          confirmation.save!
        end
      end
    end
    flash[:success] = "対象レコードの申請ステータスを変更しました。"
    redirect_to user_path
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "変更処理に失敗しました。改めて実施してください。"
    redirect_to user_path
  end
  
  private
    def attendance_confirmation_params
      params.require(:user).permit(:applicant, :application_month, :superior_id, :status)
    end
    
    def confirmation_only_params
      # params.require(:abc).permit(ccc: [:id, :status])[:ccc]
      params.require(:attendance_confirmation).permit(data: [:id, :status, :check_box])[:data]
    end
end
