class AttendanceChange < ApplicationRecord
  
  validate :change_finished_at_is_invalid_without_a_change_started_at
  validate :change_started_at_than_change_finished_at_fast_if_invalid
  validate :change_started_at_is_invalid_without_a_change_finished_at
  
  # 出勤時間が存在しない場合に、退勤時間を無効にする
  def change_finished_at_is_invalid_without_a_change_started_at
    errors.add(:change_started_at, "が必要です") if change_started_at.blank? && change_finished_at.present?
  end

  # 出勤・退勤時間がどちらも存在する時、出勤時間より早い退勤時間を無効にする
  def change_started_at_than_change_finished_at_fast_if_invalid
    if change_started_at.present? && change_finished_at.present?
      errors.add(:change_started_at, "より早い退勤時間は無効です") if change_started_at > change_finished_at
    end
  end
  
  # 退勤時間がnilの場合、出勤時間のみでのDB保存を無効にする。
  def change_started_at_is_invalid_without_a_change_finished_at
    errors.add(:change_finished_at, "が存在しない出勤時間のみの変更申請は無効です") if change_started_at.present? && change_finished_at.nil?
  end
end
