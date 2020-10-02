class CreateAttendanceChanges < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_changes do |t|
      t.string :applicant
      t.date :worked_on
      t.integer :attendance_id
      t.datetime :started_at
      t.datetime :finished_at
      t.datetime :started_at_change
      t.datetime :finished_at_change
      t.boolean :next_day_flag
      t.string :note
      t.string :status
      t.string :superior_id

      t.timestamps
    end
  end
end
