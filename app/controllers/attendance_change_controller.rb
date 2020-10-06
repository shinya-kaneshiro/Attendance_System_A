class AttendanceChangeController < ApplicationController
  
  def create
    ActiveRecord::Base.transaction do
      attendance_change_params.each do |id, item|
        unless item[:superior_id].blank?
          valid_check = AttendanceChange.find_by(attendance_id: id)
          attendance_change = valid_check.nil? ? AttendanceChange.new : valid_check

          attendance_change.update_attributes!(item)
          
          attendance_change.attendance_id = id
          attendance_change.started_at = Attendance.find(id).started_at
          attendance_change.finished_at = Attendance.find(id).finished_at
          attendance_change.change_started_at = item[:started_at]
          attendance_change.change_finished_at = item[:finished_at]
          attendance_change.save!
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "申請に失敗しました。改めて実施してください。"
    redirect_to root_url
  end
  
  def show
    if params[:date].nil?
      year = show_select_date_params["date(1i)"]
      month = show_select_date_params["date(2i)"]
      first_day = "#{year}-#{month}-01".to_date
      last_day = first_day.end_of_month
      debugger
    else
      first_day = params[:date].to_date
      last_day = first_day.end_of_month
    end

    @applicable_month = [*first_day..last_day]
    @logs = AttendanceChange.where(applicant: params[:id], worked_on: [first_day..last_day], status: "承認")
  end
  
  def change
    @changes = AttendanceChange.where(superior_id: params[:id])
    @users = User.all
  end
  
  def change_update
    number_of_updates = 0
    ActiveRecord::Base.transaction do
      change_only_params.each do |id, item|
        if item[:check_box] == "1"
          change_record = AttendanceChange.find(id)
          change_record.update_attributes!(item)
          change_record.check_box = false
          change_record.save!
          number_of_updates += 1
        end
      end
      if number_of_updates >= 1
        flash[:success] = "対象レコードの申請ステータスを変更しました。"
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
    def attendance_change_params
      params.require(:attendance).permit(attendance_change: [
                                                            :applicant,
                                                            :worked_on,
                                                            :started_at,
                                                            :finished_at,
                                                            :next_day_flag,
                                                            :note,
                                                            :status,
                                                            :superior_id
                                                            ])[:attendance_change]
    end

    def change_only_params
      params.require(:attendance_change).permit(data: [:status, :check_box])[:data]
    end
    
    def show_select_date_params
      params.require(:attendance_change).permit(:id, :date)
    end
end
