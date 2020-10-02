class CreateAttendanceConfirmations < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_confirmations do |t|
      t.string :applicant
      t.date :application_month
      t.string :status
      t.string :superior_id
      t.boolean :check_box

      t.timestamps
    end
  end
end
