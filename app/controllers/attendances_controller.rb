class AttendancesController < ApplicationController
  before_action :set_user, only: :edit_one_month
  before_action :set_one_month, only: :edit_one_month
  before_action :set_superiors, only: :edit_one_month
  before_action :logged_in_user, only: [:update, :edit_one_month, :index]
  before_action :correct_user, only: [:update, :edit_one_month]
  before_action :admin_user, only: :index
  
  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"
  
  def index
    jobs = Attendance.where(worked_on: Date.current, finished_at: nil)
    jobs = jobs.where.not(started_at: nil)
    @jobs_array = []
    jobs.each do |job|
      @jobs_array.push(User.find(job.user_id))
    end
  end

  def edit_one_month
  end

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end

end
