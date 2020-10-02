class AttendanceConfirmation < ApplicationRecord
  
  validates :superior_id, presence: true
end
