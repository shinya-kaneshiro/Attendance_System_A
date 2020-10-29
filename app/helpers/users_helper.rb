module UsersHelper
  
  # 勤怠基本情報の各時間を指定のフォーマットで返す。
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
  
  # params内に[:readonly_flag]が含まれるかどうか確認する
  def hide
    params[:readonly_flag].nil?
  end
  
  # ページ出力前に該当月の「勤怠確認申請」の申請状況を取得する。
  def attendance_confirmation_status_check
    target = AttendanceConfirmation.where(applicant: params[:id], application_month: @first_day).order(created_at: :desc).limit(1)
    if target.empty?
      return "未"
    else
      target.each do |record|
        superior = User.find(record.superior_id)
        return "申請中(#{superior.name})" if record.status == "申請中"
        return "承認済(#{superior.name})" if record.status == "承認"
        return "否認(#{superior.name})" if record.status == "否認"
      end
    end
  end

  # 自身への「勤怠確認申請」の有無、及び未承認・否認件数の確認。
  def notification_confirmation
    unapproved = AttendanceConfirmation.where(superior_id: params[:id], status: "申請中")
    unapproved_comment = "申請中#{unapproved.count}件"
    denial = AttendanceConfirmation.where(superior_id: params[:id], status: "否認")
    denial_comment = "否認#{denial.count}件"
    total_count = unapproved.count + denial.count
    if total_count != 0
      return "#{total_count}件の通知があります。（内訳:#{unapproved_comment}、#{denial_comment}）"
    end
    false
  end
  
  # 自身への「勤怠変更申請」の有無、及び未承認・否認件数の確認。
  def notification_change
    unapproved = AttendanceChange.where(superior_id: params[:id], status: "申請中")
    unapproved_comment = "申請中#{unapproved.count}件"
    denial = AttendanceChange.where(superior_id: params[:id], status: "否認")
    denial_comment = "否認#{denial.count}件"
    total_count = unapproved.count + denial.count
    if total_count != 0
      return "#{total_count}件の通知があります。（内訳:#{unapproved_comment}、#{denial_comment}）"
    end
    false
  end

  # 自身への「残業申請」の有無、及び未承認・否認件数の確認。
  def notification_overtime
    unapproved = AttendanceOvertime.where(superior_id: params[:id], status: "申請中")
    unapproved_comment = "申請中#{unapproved.count}件"
    denial = AttendanceOvertime.where(superior_id: params[:id], status: "否認")
    denial_comment = "否認#{denial.count}件"
    total_count = unapproved.count + denial.count
    if total_count != 0
      return "#{total_count}件の通知があります。（内訳:#{unapproved_comment}、#{denial_comment}）"
    end
    false
  end

  # 承認済みの残業申請がある場合、「業務処理内容」を返す。
  def business_processing_content(day)
    valid_check = AttendanceOvertime.where(
      applicant: day.user_id,
      worked_on: day.worked_on,
      status: "承認"
      ).order(created_at: :desc).limit(1)
    if valid_check.present?
      valid_check.each do |record|
        return "#{record.business_content}"
      end
    end
  end

  # 承認済みの残業申請がある場合、「終了予定時間」の「時」を返す。
  def sheduled_end_at_hour(day)
    valid_check = AttendanceOvertime.where(
      applicant: day.user_id,
      worked_on: day.worked_on,
      status: "承認"
      ).order(created_at: :desc).limit(1)
    if valid_check.present?
      valid_check.each do |record|
        return "#{record.scheduled_end_at.hour}"
      end
    end
  end

  # 承認済みの残業申請がある場合、「終了予定時間」の「分」を返す。
  def sheduled_end_at_min(day)
    valid_check = AttendanceOvertime.where(
      applicant: day.user_id,
      worked_on: day.worked_on,
      status: "承認"
      ).order(created_at: :desc).limit(1)
    if valid_check.present?
      valid_check.each do |record|
        return "#{record.scheduled_end_at.min}"
      end
    end
  end

end
