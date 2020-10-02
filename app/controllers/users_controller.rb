class UsersController < ApplicationController
  before_action :set_user, only: [:show, :confirmation]
  before_action :set_one_month, only: :show
  before_action :set_superiors, only: :show

  def index
    @users = User.where.not(admin: true)
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
  
  def import
    User.import(params[:file])
    redirect_to root_url
  end
end
