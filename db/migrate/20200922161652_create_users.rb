class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :affiliation
      t.string :employee_number
      t.string :uid
      t.datetime :basic_work_time, default: Time.current.change(hour: 8, min: 0, sec: 0)
      t.datetime :designated_work_start_time, default: Time.current.change(hour: 9, min: 0, sec: 0)
      t.datetime :designated_work_end_time, default: Time.current.change(hour: 18, min: 0, sec: 0)
      t.boolean :superior
      t.boolean :admin
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
  end
end
