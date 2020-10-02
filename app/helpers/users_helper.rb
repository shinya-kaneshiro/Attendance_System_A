module UsersHelper
  
  # 勤怠基本情報の各時間を指定のフォーマットで返す。
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
  
  # ページ出力前に該当月の勤怠確認申請の申請状況を取得する。
  def attendance_confirmation_status_check
    target = AttendanceConfirmation.find_by(applicant: params[:id], application_month: @first_day)
    if target.nil?
      return "未（申請前）"
    elsif target.status == "申請中"
      return "未（申請済み）"
    elsif target.status == "承認"
      return "#{User.find(target.manager).name}により承認済み"
    elsif target.status == "否認"
      return "#{User.find(target.manager).name}により否認済み"
    end
  end
  
  # 自身への勤怠確認申請の有無、及び未承認件数の確認。
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
end
