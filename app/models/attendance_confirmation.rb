class AttendanceConfirmation < ApplicationRecord
  
  validates :manager, presence: true
end
