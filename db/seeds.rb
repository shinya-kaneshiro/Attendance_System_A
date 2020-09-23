# coding: utf-8

User.create!(name: "一般ユーザA",
             email: "sample-a@email.com",
             department: "第一課",
             employee_number: "0155",
             card_id: "0001",
             password: "password",
             password_confirmation: "password",
             authority: "general")

User.create!(name: "一般ユーザB",
             email: "sample-b@email.com",
             department: "第二課",
             employee_number: "0177",
             card_id: "0002",
             password: "password",
             password_confirmation: "password",
             authority: "general")

User.create!(name: "上長ユーザC",
             email: "sample-c@email.com",
             department: "第一課",
             employee_number: "0078",
             card_id: "1001",
             password: "password",
             password_confirmation: "password",
             authority: "manager")

User.create!(name: "上長ユーザD",
             email: "sample-d@email.com",
             department: "第二課",
             employee_number: "0034",
             card_id: "1002",
             password: "password",
             password_confirmation: "password",
             authority: "manager")

User.create!(name: "管理ユーザE",
             email: "sample-e@email.com",
             department: "システム管理部門",
             employee_number: "0080",
             card_id: "2001",
             password: "password",
             password_confirmation: "password",
             authority: "admin")

# 100.times do |n|
#   name  = Faker::Name.name
#   email = "sample-#{n+1}@email.com"
#   password = "password"
#   User.create!(name: name,
#               email: email,
#               password: password,
#               password_confirmation: password)
#end
