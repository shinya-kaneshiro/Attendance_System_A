module AttendancesHelper

  # 出社・退社ボタンの表示/非表示の判定材料を返す。
  def attendance_state(attendance)
    if Date.current == attendance.worked_on
      return '出社' if attendance.started_at.nil?
      return '退社' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    false
  end
  
  # 在社時間を計算して返す。15分単位ver
  def working_times(start, finish, next_day_flag)
    start_time = start.hour * 60 + fifteen_minutes_conversion(start.min)
    if next_day_flag
      finish_time = (finish.hour + 24) * 60 + fifteen_minutes_conversion(finish.min)
    else
      finish_time = finish.hour * 60 + fifteen_minutes_conversion(finish.min)
    end
    format("%.2f", (finish_time - start_time) / 60.0)
  end

  # 時間外時間を計算して返す。15分単位ver
  def working_times_over(start, finish, next_day_flag)
    start_time = start.hour * 60 + fifteen_minutes_conversion(start.min)
    if next_day_flag
      finish_time = (finish.hour + 24) * 60 + fifteen_minutes_conversion(finish.min)
    else
      finish_time = finish.hour * 60 + fifteen_minutes_conversion(finish.min)
    end
    format("%.2f", ((finish_time - start_time) / 60.0) - 9)
  end

  # 勤怠表示画面の時刻表示（分）を15分単位にする。
  def fifteen_minutes_conversion(time)
    if time <= 14
      0
    elsif time <= 29
      15
    elsif time <= 44
      30
    else
      45
    end
  end
end
