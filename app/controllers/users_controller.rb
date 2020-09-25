class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_one_month, only: :show
  before_action :attendance_confirmation_status_check, only: :show
  
  def index
    @users = User.where.not(authority: "admin")
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @managers = User.where(authority: "manager")
  end
end
