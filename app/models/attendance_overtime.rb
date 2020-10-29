class AttendanceOvertime < ApplicationRecord
  
  validates :scheduled_end_at, presence: true
  validates :business_content, presence: true
  validates :superior_id, presence: true
end
