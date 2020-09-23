class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :department
      t.string :employee_number
      t.string :card_id
      t.string :password_digest
        t.datetime :basic_time, default: Time.current.change(hour: 8, min: 0, sec: 0)
      t.datetime :work_time_start, default: Time.current.change(hour: 9, min: 0, sec: 0)
      t.datetime :work_time_finish, default: Time.current.change(hour: 18, min: 0, sec: 0)
      t.string :authority

      t.timestamps
    end
  end
end
