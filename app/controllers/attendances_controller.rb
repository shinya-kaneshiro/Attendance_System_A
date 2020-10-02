class AttendancesController < ApplicationController
  before_action :set_user, only: :edit_one_month
  before_action :set_one_month, only: :edit_one_month
  before_action :set_superiors, only: :edit_one_month
  
  def edit_one_month
  end
end
