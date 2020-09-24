class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_one_month, only: :show
  
  def index
    @users = User.where.not(authority: "admin")
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
end
