class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :department
      t.string :employee_number
      t.string :card_id
      t.string :password_digest
      t.datetime :basic_time
      t.datetime :work_time_start
      t.datetime :work_time_finish
      t.string :authority

      t.timestamps
    end
  end
end
