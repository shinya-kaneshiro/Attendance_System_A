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
ApplicationStatus.create!(status: "なし")
ApplicationStatus.create!(status: "申請中")
ApplicationStatus.create!(status: "承認")
ApplicationStatus.create!(status: "否認")

# 一ヵ月分の勤怠確認申請
# AttendanceConfirmation.create!(applicant: "1",
#                               application_month: "2020-08-01",
#                               status: "申請中",
#                               superior_id: "3")

# AttendanceConfirmation.create!(applicant: "1",
#                               application_month: "2020-09-01",
#                               status: "申請中",
#                               superior_id: "3")

# AttendanceConfirmation.create!(applicant: "2",
#                               application_month: "2020-08-01",
#                               status: "申請中",
#                               superior_id: "3")

# AttendanceConfirmation.create!(applicant: "2",
#                               application_month: "2020-09-01",
#                               status: "申請中",
#                               superior_id: "3")

# 勤怠データサンプル(一般ユーザA)
 1.times do |n|
   worked_on = "2020-10-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 1.times do |n|
   worked_on = "2020-10-#{n+2}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 2.times do |n|
   worked_on = "2020-10-#{n+3}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

 1.times do |n|
   worked_on = "2020-10-#{n+5}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 05:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 1.times do |n|
   worked_on = "2020-10-#{n+6}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

# 10/7～10/9
 3.times do |n|
   worked_on = "2020-10-#{n+7}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 2.times do |n|
   worked_on = "2020-10-#{n+10}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

# 10/12～10/16
 5.times do |n|
   worked_on = "2020-10-#{n+12}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 2.times do |n|
   worked_on = "2020-10-#{n+17}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

# 10/19～10/23
 5.times do |n|
   worked_on = "2020-10-#{n+19}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

 2.times do |n|
   worked_on = "2020-10-#{n+24}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

# 10/26～10/30
 5.times do |n|
   worked_on = "2020-10-#{n+26}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

 1.times do |n|
   worked_on = "2020-10-#{n+31}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 1)
end

# 9/1
 1.times do |n|
   worked_on = "2020-09-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

# 9/2～9/30
 29.times do |n|
   worked_on = "2020-09-#{n+2}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 1)
end

# 勤怠データサンプル(上長ユーザC)
 1.times do |n|
   worked_on = "2020-10-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 1.times do |n|
   worked_on = "2020-10-#{n+2}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 2.times do |n|
   worked_on = "2020-10-#{n+3}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

 1.times do |n|
   worked_on = "2020-10-#{n+5}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 05:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 1.times do |n|
   worked_on = "2020-10-#{n+6}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

# 10/7～10/9
 3.times do |n|
   worked_on = "2020-10-#{n+7}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 2.times do |n|
   worked_on = "2020-10-#{n+10}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

# 10/12～10/16
 5.times do |n|
   worked_on = "2020-10-#{n+12}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 2.times do |n|
   worked_on = "2020-10-#{n+17}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

# 10/19～10/23
 5.times do |n|
   worked_on = "2020-10-#{n+19}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 09:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

 2.times do |n|
   worked_on = "2020-10-#{n+24}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

# 10/26～10/30
 5.times do |n|
   worked_on = "2020-10-#{n+26}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

 1.times do |n|
   worked_on = "2020-10-#{n+31}"
   Attendance.create!(worked_on: worked_on,
                      started_at: nil,
                      finished_at: nil,
                      user_id: 3)
end

# 9/1
 1.times do |n|
   worked_on = "2020-09-#{n+1}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end

# 9/2～9/30
 29.times do |n|
   worked_on = "2020-09-#{n+2}"
   Attendance.create!(worked_on: worked_on,
                      started_at: "#{worked_on} 07:00:00",
                      finished_at: "#{worked_on} 18:00:00",
                      user_id: 3)
end



# 5.times do |n|
#   worked_on = "2020-10-#{n+5}"
#   Attendance.create!(worked_on: worked_on,
#                       started_at: "#{worked_on} 09:00:00",
#                       finished_at: "#{worked_on} 18:00:00",
#                       user_id: 1)
# end

# 31.times do |n|
#   worked_on = "2020-10-#{n+1}"
#   Attendance.create!(worked_on: worked_on,
#                       user_id: 2)
# end

# 30.times do |n|
#   worked_on = "2020-09-#{n+1}"
#   Attendance.create!(worked_on: worked_on,
#                       user_id: 1)
# end

# 31.times do |n|
#   worked_on = "2020-10-#{n+1}"
#   Attendance.create!(worked_on: worked_on,
#                       user_id: 3)
# end

# 30.times do |n|
#   worked_on = "2020-09-#{n+1}"
#   Attendance.create!(worked_on: worked_on,
#                       user_id: 3)
# end

# 勤怠変更申請
# AttendanceChange.create!(
#                         applicant: "1",
#                         worked_on: "2020-10-01",
#                         attendance_id: "1",
#                         started_at: "2020-10-01 08:00:00",
#                         finished_at: "2020-10-01 17:00:00",
#                         change_started_at: "2020-10-01 07:00:00",
#                         change_finished_at: "2020-10-01 17:00:00",
#                         next_day_flag: false,
#                         note: "早出の為",
#                         status: "申請中",
#                         superior_id: "3"
#                         )

# AttendanceChange.create!(
#                         applicant: "1",
#                         worked_on: "2020-10-02",
#                         attendance_id: "2",
#                         started_at: "2020-10-02 09:00:00",
#                         finished_at: "2020-10-02 18:00:00",
#                         change_started_at: "2020-10-02 06:00:00",
#                         change_finished_at: "2020-10-02 18:00:00",
#                         next_day_flag: false,
#                         note: "早出の為",
#                         status: "申請中",
#                         superior_id: "3"
#                         )

# # AttendanceChange.create!(
# #                         applicant: "1",
# #                         worked_on: "2020-10-03",
# #                         attendance_id: "3",
# #                         started_at: "2020-10-03 08:00:00",
# #                         finished_at: "2020-10-03 17:00:00",
# #                         change_started_at: "2020-10-03 08:00:00",
# #                         change_finished_at: "2020-10-03 19:00:00",
# #                         next_day_flag: false,
# #                         note: "残業した為",
# #                         status: "申請中",
# #                         superior_id: "3"
# #                         )

# AttendanceChange.create!(
#                         applicant: "2",
#                         worked_on: "2020-10-03",
#                         attendance_id: "34",
#                         started_at: "2020-10-03 09:00:00",
#                         finished_at: "2020-10-03 18:00:00",
#                         change_started_at: "2020-10-03 09:00:00",
#                         change_finished_at: "2020-10-03 20:00:00",
#                         next_day_flag: false,
#                         note: "残業した為",
#                         status: "申請中",
#                         superior_id: "3"
#                         )

# AttendanceChange.create!(
#                         applicant: "2",
#                         worked_on: "2020-10-04",
#                         attendance_id: "35",
#                         started_at: "2020-10-04 09:00:00",
#                         finished_at: "2020-10-04 18:00:00",
#                         change_started_at: "2020-10-04 09:00:00",
#                         change_finished_at: "2020-10-04 21:00:00",
#                         next_day_flag: false,
#                         note: "残業した為",
#                         status: "申請中",
#                         superior_id: "3"
#                         )

# 勤怠変更申請（勤怠ログ用、一般ユーザA）
AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-02",
                        attendance_id: "2",
                        started_at: "2020-10-02 09:00:00",
                        finished_at: "2020-10-02 18:00:00",
                        change_started_at: "2020-10-02 07:00:00",
                        change_finished_at: "2020-10-02 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3"
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-05",
                        attendance_id: "5",
                        started_at: "2020-10-05 09:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 07:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3"
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-05",
                        attendance_id: "5",
                        started_at: "2020-10-05 07:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 06:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為（再申請）",
                        status: "承認",
                        superior_id: "3"
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-05",
                        attendance_id: "5",
                        started_at: "2020-10-05 06:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 05:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為（再申請）",
                        status: "承認",
                        superior_id: "3"
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-10-06",
                        attendance_id: "6",
                        started_at: "2020-10-06 09:00:00",
                        finished_at: "2020-10-06 18:00:00",
                        change_started_at: "2020-10-06 07:00:00",
                        change_finished_at: "2020-10-06 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3"
                        )

AttendanceChange.create!(
                        applicant: "1",
                        worked_on: "2020-09-01",
                        attendance_id: "32",
                        started_at: "2020-09-01 09:00:00",
                        finished_at: "2020-09-01 18:00:00",
                        change_started_at: "2020-09-01 07:00:00",
                        change_finished_at: "2020-09-01 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "3"
                        )

# 勤怠変更申請（勤怠ログ用、上長ユーザC）
AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-10-02",
                        attendance_id: "63",
                        started_at: "2020-10-02 09:00:00",
                        finished_at: "2020-10-02 18:00:00",
                        change_started_at: "2020-10-02 07:00:00",
                        change_finished_at: "2020-10-02 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "4"
                        )

AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-10-05",
                        attendance_id: "66",
                        started_at: "2020-10-05 09:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 07:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "4"
                        )

AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-10-05",
                        attendance_id: "66",
                        started_at: "2020-10-05 07:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 06:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為（再申請）",
                        status: "承認",
                        superior_id: "4"
                        )

AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-10-05",
                        attendance_id: "66",
                        started_at: "2020-10-05 06:00:00",
                        finished_at: "2020-10-05 18:00:00",
                        change_started_at: "2020-10-05 05:00:00",
                        change_finished_at: "2020-10-05 18:00:00",
                        next_day_flag: false,
                        note: "早出の為（再申請）",
                        status: "承認",
                        superior_id: "4"
                        )

AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-10-06",
                        attendance_id: "67",
                        started_at: "2020-10-06 09:00:00",
                        finished_at: "2020-10-06 18:00:00",
                        change_started_at: "2020-10-06 07:00:00",
                        change_finished_at: "2020-10-06 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "4"
                        )

AttendanceChange.create!(
                        applicant: "3",
                        worked_on: "2020-09-01",
                        attendance_id: "93",
                        started_at: "2020-09-01 09:00:00",
                        finished_at: "2020-09-01 18:00:00",
                        change_started_at: "2020-09-01 07:00:00",
                        change_finished_at: "2020-09-01 18:00:00",
                        next_day_flag: false,
                        note: "早出の為",
                        status: "承認",
                        superior_id: "4"
                        )

# # 残業申請
# AttendanceOvertime.create!(
#                           applicant: "1",
#                           worked_on: "2020-10-03",
#                           attendance_id: 3,
#                           scheduled_end_at: "2020-10-04 04:00:00",
#                           next_day_flag: true,
#                           business_content: "翌日04:00まで",
#                           status: "申請中",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# AttendanceOvertime.create!(
#                           applicant: "1",
#                           worked_on: "2020-10-04",
#                           attendance_id: 4,
#                           scheduled_end_at: "2020-10-04 20:00:00",
#                           next_day_flag: false,
#                           business_content: "当日20:00まで",
#                           status: "申請中",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# AttendanceOvertime.create!(
#                           applicant: "1",
#                           worked_on: "2020-10-12",
#                           attendance_id: 12,
#                           scheduled_end_at: "2020-10-12 20:15:00",
#                           next_day_flag: false,
#                           business_content: "当日20:15まで",
#                           status: "承認",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# AttendanceOvertime.create!(
#                           applicant: "1",
#                           worked_on: "2020-10-13",
#                           attendance_id: 13,
#                           scheduled_end_at: "2020-10-14 06:45:00",
#                           next_day_flag: false,
#                           business_content: "翌日06:45まで",
#                           status: "承認",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# AttendanceOvertime.create!(
#                           applicant: "2",
#                           worked_on: "2020-10-03",
#                           attendance_id: 34,
#                           scheduled_end_at: "2020-10-04 04:00:00",
#                           next_day_flag: true,
#                           business_content: "翌日04:00まで",
#                           status: "申請中",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# AttendanceOvertime.create!(
#                           applicant: "2",
#                           worked_on: "2020-10-04",
#                           attendance_id: 35,
#                           scheduled_end_at: "2020-10-04 20:00:00",
#                           next_day_flag: false,
#                           business_content: "当日20:00まで",
#                           status: "申請中",
#                           superior_id: "3",
#                           check_box: nil
#                           )

# 拠点情報
Base.create!(base_number: "1", base_name: "拠点A", attendance_type: "出勤")
Base.create!(base_number: "2", base_name: "拠点B", attendance_type: "退勤")

# 100.times do |n|
#   name  = Faker::Name.name
#   email = "sample-#{n+1}@email.com"
#   password = "password"
#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
#end
