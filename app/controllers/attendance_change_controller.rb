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
          attendance_change.started_at_change = item[:started_at]
          attendance_change.finished_at_change = item[:finished_at]
          attendance_change.save!
        end
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "申請に失敗しました。改めて実施してください。"
    redirect_to root_url
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
end
