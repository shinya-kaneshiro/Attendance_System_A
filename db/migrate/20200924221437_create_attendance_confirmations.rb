class CreateAttendanceConfirmations < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_confirmations do |t|
      t.string :applicant
      t.date :application_month
      t.string :status
      t.string :manager

      t.timestamps
    end
  end
end
