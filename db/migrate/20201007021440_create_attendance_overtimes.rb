class CreateAttendanceOvertimes < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_overtimes do |t|
      t.string :applicant
      t.date :worked_on
      t.integer :attendance_id
      t.datetime :scheduled_end_at
      t.boolean :next_day_flag
      t.string :business_content
      t.string :status
      t.string :superior_id
      t.boolean :check_box

      t.timestamps
    end
  end
end
