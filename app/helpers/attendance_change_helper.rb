module AttendanceChangeHelper
  
  # 勤怠変更申請の申請状況を該当日付に表示させる
  def change_status_display(day)
    extraction_record = AttendanceChange.where(applicant: @user.id, worked_on: day.worked_on).order(created_at: :desc).limit(1)
    if extraction_record.present?
      extraction_record.each do |record|
        # return "勤怠変更申請中" if record.status == "申請中"
        # return "勤怠変更承認済" if record.status == "承認"
        # return "勤怠変更否認" if record.status == "否認"
        superior = User.find(record.superior_id)
        return "勤怠変更申請中(#{superior.name})" if record.status == "申請中"
        return "勤怠変更承認済(#{superior.name})" if record.status == "承認"
        return "勤怠変更否認(#{superior.name})" if record.status == "否認"
      end
    end
    # return "" unless extraction_record.present?
    # if extraction_record.count == 1
    #   extraction_record.each do |record|
    #     return "勤怠編集 #{record.status}済" if record.status == "承認"
    #     return "勤怠編集 #{record.status}" if record.status == "否認"
    #     return "" if record.status == "申請中"
    #   end
    # elsif extraction_record.count >= 2
    #   extraction_record.each do |record|
    #     return "勤怠編集 #{record.status}済" if record.status == "承認"
    #     return "勤怠編集 #{record.status}" if record.status == "否認"
    #     return "" if record.status == "申請中"
    #   end
    # end
  end
  
  # 勤怠ログ用、該当日付のレコードが存在するか確認し、レコード数を返す。
  def does_the_date_exist(day)
    target_record = @logs.where(worked_on: day)
    if target_record.present?
      return target_record.count
    end
  end
  
  # 勤怠ログ用、重複していない対象日付のレコードを返す。
  def get_single_record(day)
    single_record = []
    target_record = @logs.find_by(worked_on: day)
    single_record.push(format_basic_info(target_record.started_at))
    single_record.push(format_basic_info(target_record.finished_at))
    single_record.push(format_basic_info(target_record.change_started_at))
    single_record.push(format_basic_info(target_record.change_finished_at))
    single_record.push(User.find(target_record.superior_id).name)
    single_record.push(target_record.updated_at.to_date)
  end
  
  # # 勤怠ログ用、同一日付が複数レコードある場合、必要な「変更前出社時間」を返す。
  # def get_started_at(day)
  #   target_record = @logs.where(worked_on: day).order(created_at: :asc).limit(1)
  #   target_record.each { |bbb| return bbb.started_at}
  # end

  # # 勤怠ログ用、同一日付が複数レコードある場合、必要な「変更前退社時間」を返す。
  # def get_finished_at(day)
  #   target_record = @logs.where(worked_on: day).order(created_at: :asc).limit(1)
  #   target_record.each { |bbb| return bbb.finished_at}
  # end

  # # 勤怠ログ用、同一日付が複数レコードある場合、必要な「変更後出社時間」を返す。
  # def get_change_started_at(day)
  #   target_record = @logs.where(worked_on: day).order(created_at: :desc).limit(1)
  #   target_record.each { |bbb| return bbb.change_started_at}
  # end

  # # 勤怠ログ用、同一日付が複数レコードある場合、必要な「変更後退社時間」を返す。
  # def get_change_finished_at(day)
  #   target_record = @logs.where(worked_on: day).order(created_at: :desc).limit(1)
  #   target_record.each { |bbb| return bbb.change_finished_at}
  # end
  
  #勤怠ログ用、同一日付のレコードが複数ある場合に必要な値を配列に入れて返す。
  def get_multiple_records(day)
    multiple_records = []
    target_record = @logs.where(worked_on: day).order(created_at: :asc).limit(1)
    target_record.each do |record|
      multiple_records.push(format_basic_info(record.started_at))
      multiple_records.push(format_basic_info(record.finished_at))
    end
    target_record = @logs.where(worked_on: day).order(created_at: :desc).limit(1)
    target_record.each do |record|
      multiple_records.push(format_basic_info(record.change_started_at))
      multiple_records.push(format_basic_info(record.change_finished_at))
      multiple_records.push(User.find(record.superior_id).name)
      multiple_records.push(record.updated_at.to_date)
    end
    return multiple_records
  end
  
  # 勤怠変更申請を承認した場合、申請者の勤怠情報を更新する。
  def applicant_attendance_update(record)
    target_record = Attendance.find(record.attendance_id)
    target_record.started_at = record.change_started_at
    target_record.finished_at = record.change_finished_at
    target_record.next_day_flag = record.next_day_flag
    target_record.save!
  end
  
  # 勤怠変更申請が承認された場合、備考を返す。
  def approved_remarks(record)
    extraction_record = AttendanceChange.where(applicant: record.user_id, worked_on: record.worked_on).order(created_at: :desc).limit(1)
    if extraction_record.present?
      extraction_record.each do |record|
        return record.note if record.status == "承認"
        return "" unless record.status == "承認"
      end
    end
  end
end
