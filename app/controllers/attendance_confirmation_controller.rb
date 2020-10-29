class AttendanceConfirmationController < ApplicationController
  before_action :set_user, only: [:create, :confirmation_update]
  before_action :logged_in_user, only: [:create, :confirmation, :confirmation_update]
  before_action :correct_user, only: [:create, :confirmation, :confirmation_update]

  def create
    valid_check = AttendanceConfirmation.find_by(
      applicant: attendance_confirmation_params["applicant"],
      application_month: attendance_confirmation_params["application_month"],
      status: attendance_confirmation_params["status"]
      )
    if valid_check.nil?
      attendance_confirmation = AttendanceConfirmation.new(attendance_confirmation_params)
      application_month = attendance_confirmation.application_month
      if attendance_confirmation.save
        flash[:success] = "一ヶ月分の勤怠確認申請を送信しました。"
        redirect_to user_path(@user, date: application_month)
      else
        flash[:danger] = "申請に失敗しました。"
        redirect_to user_path(@user, date: application_month)
      end
    else
      flash[:info] = "既に申請中です。承認/否認/取り消し後に改めて実施してください。"
      redirect_to user_path(@user, date: application_month)
    end
  end
  
  def confirmation
    confirmations = AttendanceConfirmation.where(superior_id: params[:id])
    @confirmations = confirmations.where.not(status: "承認")
    @users = User.all
  end
  
  def confirmation_update
    number_of_updates = 0
    ActiveRecord::Base.transaction do
      confirmation_only_params.each do |id, item|
        if item[:check_box] == "1"
          confirmation = AttendanceConfirmation.find(id)
          confirmation.update_attributes!(item)
          if confirmation.status == "なし"
            confirmation.destroy!
            number_of_updates += 1
          else
            confirmation.check_box = false
            confirmation.save!
            number_of_updates += 1
          end
        end
      end
      if number_of_updates >= 1
        flash[:success] = "#{number_of_updates}件の処理が完了しました。"
      elsif number_of_updates == 0
        flash[:danger] = "変更対象のレコードにチェックを入れてください。"
      end
      redirect_to user_path
    end
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
