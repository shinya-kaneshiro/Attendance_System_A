class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :set_one_month, only: :show
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end
end
