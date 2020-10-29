module AttendanceOvertimeHelper
  
  # 申請者の指定勤務終了時間を取得し、当日日付に変換して返す。
  def get_designated_work_end_time(user, attendance)
    user = User.find(user)
    attendance = Attendance.find(attendance)
    target_hour = user.designated_work_end_time.hour
    target_min = user.designated_work_end_time.min
    current_day_convert = "#{attendance.worked_on} #{target_hour}:#{target_min}:00"
    current_day_convert = current_day_convert.to_datetime
  end
  
  # 時間外勤務時間を返す
  def overtime_hours(designated_work_end_time, scheduled_end_at)
    calculation_process_1 = scheduled_end_at - designated_work_end_time
    calculation_process_2 = calculation_process_1 + 3600 * 9
    return format("%.2f", (calculation_process_2 / 60) / 60.0)
  end
  # 時間外勤務時間を返す(遠回り)
  # def overtime_hours(designated_work_end_time, scheduled_end_at)
  #   designated_work_end_time_hour = designated_work_end_time.hour
  #   designated_work_end_time_min = designated_work_end_time.min
  #   scheduled_end_at_hour = scheduled_end_at.hour
  #   scheduled_end_at_min = scheduled_end_at.min
  #   scheduled_end_at_hour += 24 unless designated_work_end_time.day == scheduled_end_at.day
  #   hour_calculation = scheduled_end_at_hour - designated_work_end_time_hour
    
  #   designated_work_end_time_min = 15
    
  #   aaa = "#{hour_calculation}:#{scheduled_end_at_min}"
  #   aaa = aaa.to_datetime
  #   ccc = aaa - Rational(designated_work_end_time_min, 24 * 60) 
  #   debugger
  # end
  
  # 終了予定時間を「hh:mm」形式で返す。
  def hhmm_convert(target_time)
    hour = target_time.hour
    min = target_time.min
    sprintf("%d:%02d", hour, min)
  end
  
  # 残業申請の申請状況を該当日付に表示させる
  def overtime_status_display(day)
    target_record = AttendanceOvertime.where(applicant: @user.id, worked_on: day.worked_on).order(created_at: :desc).limit(1)
    if target_record.present?
      target_record.each do |record|
        # return "残業申請中" if record.status == "申請中"
        # return "残業承認済" if record.status == "承認"
        # return "残業否認" if record.status == "否認"
        superior = User.find(record.superior_id)
        return "残業申請中(#{superior.name})" if record.status == "申請中"
        return "残業承認済(#{superior.name})" if record.status == "承認"
        return "残業否認(#{superior.name})" if record.status == "否認"
      end
    end
  end
end
