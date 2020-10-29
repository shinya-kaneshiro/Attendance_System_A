class AttendanceChangeController < ApplicationController
  include AttendanceChangeHelper
  
  before_action :logged_in_user, only: [:create, :change, :change_update, :show]
  before_action :correct_user, only: [:create, :change, :change_update, :show]
  
  def create
    superior_count = 0
    duplicate_count = 0
    ActiveRecord::Base.transaction do
      attendance_change_params.each do |id, item|
        unless item[:superior_id].blank?
          # valid_check = AttendanceChange.find_by(attendance_id: id)
          # attendance_change = valid_check.nil? ? AttendanceChange.new : valid_check
          valid_check = AttendanceChange.find_by(attendance_id: id, status: "申請中")
          
          if valid_check.nil?
            attendance_change = AttendanceChange.new(item)
            # attendance_change.update_attributes!(item)
  
            attendance_change.attendance_id = id
            attendance_change.started_at = Attendance.find(id).started_at
            attendance_change.finished_at = Attendance.find(id).finished_at
            
            target_hour = item["started_at(4i)"].blank? ? nil : item["started_at(4i)"]
            target_min = item["started_at(5i)"].blank? ? nil : item["started_at(5i)"]
            if target_hour.nil? || target_min.nil?
              attendance_change.change_started_at = nil
            else
              attendance_change.change_started_at = "#{item["worked_on"]} #{target_hour}:#{target_min}:00"
            end
            
            target_hour = item["finished_at(4i)"].blank? ? nil : item["finished_at(4i)"]
            target_min = item["finished_at(5i)"].blank? ? nil : item["finished_at(5i)"]
            if item["next_day_flag"] == "1"
              finished_worked_on = item["worked_on"].to_date + 1
            else
              finished_worked_on = item["worked_on"].to_date
            end
  
            if target_hour.nil? || target_min.nil?
              attendance_change.change_finished_at = nil
            else
              attendance_change.change_finished_at = "#{finished_worked_on} #{target_hour}:#{target_min}:00"
            end
            
            attendance_change.save!
            superior_count += 1
          else
            duplicate_count += 1
          end
        end
      end
      if duplicate_count == 0 && superior_count >= 1
        flash[:success] = "勤怠変更申請を送信しました。"
        redirect_to user_url(date: params[:date])
      elsif duplicate_count >= 1 && superior_count >= 1
        flash[:success] = "勤怠変更申請を送信しました(内#{duplicate_count}件は既に申請済みの為、承認者側の処理を受けてから、改めて実施してください)。"
        redirect_to user_url(date: params[:date])
      elsif duplicate_count >= 1 && superior_count == 0
        flash[:danger] = "対象レコードは既に申請中です。承認者側の処理を受けてから、改めて実施してください。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      else
        flash[:danger] = "申請先上長を選択してください。"
        redirect_to attendances_edit_one_month_user_url(date: params[:date])
      end
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "申請に失敗しました。改めて実施してください。"
    redirect_to user_url
  end
  
  # createアクション（時刻表示を「x.time_field」から「x.time_select」に変更する前のロジック）
  # def create
  #   debugger
  #   ActiveRecord::Base.transaction do
  #     attendance_change_params.each do |id, item|
  #       unless item[:superior_id].blank?
  #         valid_check = AttendanceChange.find_by(attendance_id: id)
  #         attendance_change = valid_check.nil? ? AttendanceChange.new : valid_check

  #         attendance_change.update_attributes!(item)
          
  #         attendance_change.attendance_id = id
  #         attendance_change.started_at = Attendance.find(id).started_at
  #         attendance_change.finished_at = Attendance.find(id).finished_at
  #         attendance_change.change_started_at = item[:started_at]
  #         attendance_change.change_finished_at = item[:finished_at]
  #         attendance_change.save!
  #       end
  #     end
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   flash[:danger] = "申請に失敗しました。改めて実施してください。"
  #   redirect_to root_url
  # end
  
  def show
    if params[:date].nil?
      year = show_select_date_params["date(1i)"]
      month = show_select_date_params["date(2i)"]
      first_day = "#{year}-#{month}-01".to_date
      last_day = first_day.end_of_month
    else
      first_day = params[:date].to_date
      last_day = first_day.end_of_month
    end

    @applicable_month = [*first_day..last_day]
    @logs = AttendanceChange.where(applicant: params[:id], worked_on: [first_day..last_day], status: "承認")
    @first_day = first_day
    
    unless @logs.present?
      flash.now[:danger] = "選択された年月に承認済みレコードは存在しません。"
    end
  end
  
  def change
    changes = AttendanceChange.where(superior_id: params[:id])
    @changes = changes.where.not(status: "承認")
    @users = User.all
  end
  
  def change_update
    number_of_updates = 0
    ActiveRecord::Base.transaction do
      change_only_params.each do |id, item|
        if item[:check_box] == "1"
          change_record = AttendanceChange.find(id)
          change_record.update_attributes!(item)
          if change_record.status == "なし"
            change_record.destroy!
            number_of_updates += 1
          else
            change_record.check_box = false
            change_record.save!
            applicant_attendance_update(change_record) if change_record.status == "承認"
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
    flash[:danger] = "更新処理に失敗しました。改めて実施してください。"
    redirect_to user_path
  end

  # 「なし」ステータスで削除処理を追加する前  
  # def change_update
  #   number_of_updates = 0
  #   ActiveRecord::Base.transaction do
  #     change_only_params.each do |id, item|
  #       if item[:check_box] == "1"
  #         change_record = AttendanceChange.find(id)
  #         change_record.update_attributes!(item)
  #         change_record.check_box = false
  #         change_record.save!
  #         applicant_attendance_update(change_record) if change_record.status == "承認"
  #         number_of_updates += 1
  #       end
  #     end
  #     if number_of_updates >= 1
  #       flash[:success] = "対象レコードの申請ステータスを変更しました。"
  #     elsif number_of_updates == 0
  #       flash[:danger] = "変更対象のレコードにチェックを入れてください。"
  #     end
  #     redirect_to user_path
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   flash[:danger] = "変更処理に失敗しました。改めて実施してください。"
  #   redirect_to user_path
  # end

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
