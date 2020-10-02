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

# 100.times do |n|
#   name  = Faker::Name.name
#   email = "sample-#{n+1}@email.com"
#   password = "password"
#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
#end
