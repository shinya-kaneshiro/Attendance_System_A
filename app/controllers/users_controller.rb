class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :set_one_month, only: :show
  before_action :set_superiors, only: :show
  before_action :logged_in_user, only: [:show, :index, :import, :edit, :update, :destroy]
  before_action :superior_or_correct_user, only: :show
  before_action :admin_user, only: [:index, :edit, :import, :update, :destroy]

  def index
    @users = User.where.not(id: current_user.id).order(id: :asc)
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "#{@user.name}_#{@first_day.year}年#{@first_day.month}月分.csv", type: :csv
        # send_data render_to_string, filename: "#{@user.name}_#{csv_year}年#{csv_month}月分_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.csv", type: :csv
      end
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to users_url
    else
      @users = User.where.not(id: current_user.id).order(id: :asc)
      render :index
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_path
  end
  
  def import
    User.import(params[:file])
    flash[:info] = "CSVインポート処理が完了しました。"
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(
                                  :name,
                                  :email,
                                  :affiliation,
                                  :employee_number,
                                  :uid,
                                  :basic_work_time,
                                  :designated_work_start_time,
                                  :designated_work_end_time,
                                  :password,
                                  :password_confirmation)
    end
end
