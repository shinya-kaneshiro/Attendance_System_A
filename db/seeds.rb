# coding: utf-8

# ユーザ作成
User.create!(name: "一般ユーザA",
            email: "sample-a@email.com",
            affiliation: "第一課",
            employee_number: "0155",
            uid: "0001",
            password: "password",
            password_confirmation: "password",
            superior: false,
            admin: false)

User.create!(name: "一般ユーザB",
            email: "sample-b@email.com",
            affiliation: "第二課",
            employee_number: "0177",
            uid: "0002",
            password: "password",
            password_confirmation: "password",
            superior: false,
            admin: false)

User.create!(name: "上長ユーザC",
            email: "sample-c@email.com",
            affiliation: "第一課",
            employee_number: "0078",
            uid: "1001",
            password: "password",
            password_confirmation: "password",
            superior: true,
            admin: false)

User.create!(name: "上長ユーザD",
            email: "sample-d@email.com",
            affiliation: "第二課",
            employee_number: "0034",
            uid: "1002",
            password: "password",
            password_confirmation: "password",
            superior: true,
            admin: false)

User.create!(name: "管理ユーザE",
            email: "sample-e@email.com",
            affiliation: "システム管理部門",
            employee_number: "0080",
            uid: "2001",
            password: "password",
            password_confirmation: "password",
            superior: false,
            admin: true)

# 申請ステータス
ApplicationStatus.create!(status: "申請中")
ApplicationStatus.create!(status: "承認")
ApplicationStatus.create!(status: "否認")

# 一ヵ月分の勤怠確認申請
AttendanceConfirmation.create!(applicant: "1",
                              application_month: "2020-08-01",
                              status: "申請中",
                              superior_id: "3")

AttendanceConfirmation.create!(applicant: "1",
                               application_month: "2020-09-01",
                               status: "申請中",
                               superior_id: "3")

AttendanceConfirmation.create!(applicant: "2",
                               application_month: "2020-08-01",
                               status: "申請中",
                               superior_id: "3")

AttendanceConfirmation.create!(applicant: "2",
                               application_month: "2020-09-01",
                               status: "申請中",
                               superior_id: "3")

# 勤怠データサンプル
 31.times do |n|
   worked_on = "2020-10-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      user_id: 1)
end

 31.times do |n|
   worked_on = "2020-10-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      user_id: 2)
end

 30.times do |n|
   worked_on = "2020-09-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      user_id: 1)
end

# 勤怠変更申請
AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-01",
                        attendance_id: "1",
                        started_at: "2020-10-01 08:00:00",
                        finished_at: "2020-10-01 17:00:00",
                        change_started_at: "2020-10-01 07:00:00",
                        change_finished_at: "2020-10-01 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "申請中",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-02",
                        attendance_id: "2",
                        started_at: "2020-10-02 08:00:00",
                        finished_at: "2020-10-02 17:00:00",
                        change_started_at: "2020-10-02 06:00:00",
                        change_finished_at: "2020-10-02 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "申請中",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-03",
                        attendance_id: "3",
                        started_at: "2020-10-03 08:00:00",
                        finished_at: "2020-10-03 17:00:00",
                        change_started_at: "2020-10-03 08:00:00",
                        change_finished_at: "2020-10-03 19:00:00",
                        next_day_flag: false,
                        note: "残業した為",
                        status: "申請中",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "2",
                        worked_on: "2020-10-03",
                        attendance_id: "34",
                        started_at: "2020-10-03 08:00:00",
                        finished_at: "2020-10-03 17:00:00",
                        change_started_at: "2020-10-03 08:00:00",
                        change_finished_at: "2020-10-03 20:00:00",
                        next_day_flag: false,
                        note: "残業した為（前回申請の訂正）",
                        status: "申請中",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "2",
                        worked_on: "2020-10-04",
                        attendance_id: "35",
                        started_at: "2020-10-04 08:00:00",
                        finished_at: "2020-10-04 17:00:00",
                        change_started_at: "2020-10-04 08:00:00",
                        change_finished_at: "2020-10-04 20:00:00",
                        next_day_flag: false,
                        note: "残業した為（前回申請の訂正）",
                        status: "申請中",
                        superior_id: "3",
                        )

# 勤怠変更申請（勤怠ログ用）
AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-03",
                        attendance_id: "3",
                        started_at: "2020-10-03 08:00:00",
                        finished_at: "2020-10-03 17:00:00",
                        change_started_at: "2020-10-03 07:00:00",
                        change_finished_at: "2020-10-03 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-04",
                        attendance_id: "4",
                        started_at: "2020-10-04 08:00:00",
                        finished_at: "2020-10-04 17:00:00",
                        change_started_at: "2020-10-04 07:00:00",
                        change_finished_at: "2020-10-04 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-04",
                        attendance_id: "4",
                        started_at: "2020-10-04 08:00:00",
                        finished_at: "2020-10-04 17:00:00",
                        change_started_at: "2020-10-04 06:00:00",
                        change_finished_at: "2020-10-04 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-04",
                        attendance_id: "4",
                        started_at: "2020-10-04 08:00:00",
                        finished_at: "2020-10-04 17:00:00",
                        change_started_at: "2020-10-04 05:00:00",
                        change_finished_at: "2020-10-04 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-05",
                        attendance_id: "5",
                        started_at: "2020-10-05 08:00:00",
                        finished_at: "2020-10-05 17:00:00",
                        change_started_at: "2020-10-05 07:00:00",
                        change_finished_at: "2020-10-05 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-09-01",
                        attendance_id: "63",
                        started_at: "2020-09-01 08:00:00",
                        finished_at: "2020-09-01 17:00:00",
                        change_started_at: "2020-09-01 07:00:00",
                        change_finished_at: "2020-09-01 17:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3",
                        )

# 100.times do |n|
#   name  = Faker::Name.name
#   email = "sample-#{n+1}@email.com"
#   password = "password"
#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
#end
