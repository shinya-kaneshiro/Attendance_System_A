class AttendanceOvertimeController < ApplicationController
  before_action :set_superiors, only: :new
  before_action :logged_in_user, only: [:new, :create, :overtime, :overtime_update]
  before_action :correct_user, only: [:new, :craete, :overtime, :overtime_update]
  
  def new
    @attendance = Attendance.find(params[:attendance_id])
  end
  
  def create
    valid_check = AttendanceOvertime.find_by(
      applicant: overtime_params["applicant"],
      worked_on: overtime_params["worked_on"],
      status: overtime_params["status"]
      )

    if valid_check.nil?
      user_designated_work_end_time = User.find(overtime_params["applicant"]).designated_work_end_time
      user_hour = user_designated_work_end_time.hour
      
      target_hour = overtime_params["scheduled_end_at(4i)"]
      target_min = overtime_params["scheduled_end_at(5i)"]
      
      if target_hour.present? && target_min.present?
        if overtime_params["next_day_flag"] == "1"
          worked_on_next = overtime_params["worked_on"].to_datetime + 1
          scheduled_end_at = "#{worked_on_next} #{target_hour}:#{target_min}:00"
        else
          scheduled_end_at = "#{overtime_params["worked_on"]} #{target_hour}:#{target_min}:00"
        end
      else
        scheduled_end_at = ""
      end
      
      overtime = AttendanceOvertime.new(overtime_params)
      overtime.scheduled_end_at = scheduled_end_at
      
      if (user_hour.to_i > target_hour.to_i) && overtime_params["next_day_flag"] == "0"
        flash[:danger] = "指定勤務時間より後の時間を選択してください。"
        redirect_to user_url(date: overtime.worked_on.beginning_of_month)
      elsif overtime.save
        flash[:success] = "残業申請を送信しました。"
        redirect_to user_url(date: overtime.worked_on.beginning_of_month)
      else
        flash[:danger] = "申請処理が失敗しました。改めて実施してください。"
        redirect_to user_url(date: overtime.worked_on.beginning_of_month)
      end
    else
      flash[:info] = "既に申請中です。承認/否認/取り消し後に改めて実施してください。"
      redirect_to user_url(date: overtime_params["worked_on"].to_date.beginning_of_month)
    end
  end

  # 該当ユーザの指定勤務終了時間より前の申請を弾く機能を実装する前
  # def create
  #   valid_check = AttendanceOvertime.find_by(
  #     applicant: overtime_params["applicant"],
  #     worked_on: overtime_params["worked_on"],
  #     status: overtime_params["status"]
  #     )
  #   if valid_check.nil?
  #     if overtime_params["scheduled_end_at(4i)"].present? && overtime_params["scheduled_end_at(5i)"].present?
  #       target_hour = overtime_params["scheduled_end_at(4i)"]
  #       target_min = overtime_params["scheduled_end_at(5i)"]
  #       if overtime_params["next_day_flag"] == "1"
  #         worked_on_next = overtime_params["worked_on"].to_datetime + 1
  #         scheduled_end_at = "#{worked_on_next} #{target_hour}:#{target_min}:00"
  #       else
  #         scheduled_end_at = "#{overtime_params["worked_on"]} #{target_hour}:#{target_min}:00"
  #       end
  #     else
  #       scheduled_end_at = ""
  #     end
      
  #     overtime = AttendanceOvertime.new(overtime_params)
  #     overtime.scheduled_end_at = scheduled_end_at
      
  #     if overtime.save
  #       flash[:success] = "残業申請を送信しました。"
  #       redirect_to user_url(date: overtime.worked_on.beginning_of_month)
  #     else
  #       flash[:danger] = "申請処理が失敗しました。改めて実施してください。"
  #       redirect_to user_url(date: overtime.worked_on.beginning_of_month)
  #     end
  #   else
  #     flash[:info] = "既に申請中です。承認/否認/取り消し後に改めて実施してください。"
  #     redirect_to user_url(date: overtime_params["worked_on"].to_date.beginning_of_month)
  #   end
  # end

  # DB保存時に9時間ズレるのを解消する前  
  # def create
  #   valid_check = AttendanceOvertime.find_by(
  #     applicant: overtime_params["applicant"],
  #     worked_on: overtime_params["worked_on"],
  #     status: overtime_params["status"]
  #     )
  #   if valid_check.nil?
  #     if overtime_params["scheduled_end_at(4i)"].present? && overtime_params["scheduled_end_at(5i)"].present?
  #       target_hour = overtime_params["scheduled_end_at(4i)"]
  #       target_min = overtime_params["scheduled_end_at(5i)"]
  #       scheduled_end_at = "#{overtime_params["worked_on"]} #{target_hour}:#{target_min}:00"
  #       if overtime_params["next_day_flag"] == "1"
  #         scheduled_end_at = scheduled_end_at.to_datetime + 1
  #       else
  #         scheduled_end_at = scheduled_end_at.to_datetime
  #       end
  #     else
  #       scheduled_end_at = ""
  #     end
      
  #     overtime = AttendanceOvertime.new(overtime_params)
  #     overtime.scheduled_end_at = scheduled_end_at
      
  #     if overtime.save
  #       flash[:success] = "残業申請を送信しました。"
  #       redirect_to user_url(date: overtime.worked_on.beginning_of_month)
  #     else
  #       flash[:danger] = "申請処理が失敗しました。改めて実施してください。"
  #       redirect_to user_url(date: overtime.worked_on.beginning_of_month)
  #     end
  #   else
  #     flash[:info] = "既に申請中です。承認/否認/取り消し後に改めて実施してください。"
  #     redirect_to user_url(date: overtime_params["worked_on"].to_date.beginning_of_month)
  #   end
  # end
  
  def overtime
    # overtimes = AttendanceOvertime.where(superior_id: params[:id])
    overtimes = AttendanceOvertime.where(superior_id: params[:id])
    @overtimes = overtimes.where.not(status: "承認")
    @users = User.all.order(id: :asc)
  end

  def overtime_update
    number_of_updates = 0
    ActiveRecord::Base.transaction do
      overtime_update_params.each do |id, item|
        if item[:check_box] == "1"
          overtime = AttendanceOvertime.find(id)
          overtime.update_attributes!(item)
          if overtime.status == "なし"
            overtime.destroy!
            number_of_updates += 1
          else
            overtime.check_box = false
            overtime.save!
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
    
    def overtime_params
      params.require(:attendance_overtime).permit(:applicant,
                                                  :worked_on,
                                                  :attendance_id,
                                                  :scheduled_end_at,
                                                  :next_day_flag,
                                                  :business_content,
                                                  :status,
                                                  :superior_id)
    end
    
    def overtime_update_params
      params.require(:attendance_overtime).permit(data: [
                                                        :id,
                                                        :status,
                                                        :check_box
                                                        ])[:data]
    end
end
