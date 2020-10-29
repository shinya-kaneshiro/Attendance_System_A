class BasesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :create, :destroy, :edit, :update]
  
  def index
    @bases = Base.all
  end
  
  def create
    base = Base.new
    base.base_number = "拠点番号（未設定）"
    base.base_name = "拠点名(未設定)"
    base.attendance_type = "出勤種類(未設定)"
    if base.save
      flash[:success] = "拠点情報を追加しました。"
      redirect_to user_bases_url
    end
  end
  
  def edit
    @base = Base.find(params[:id])
  end
  
  def update
    @base = Base.find(params[:id])
    if @base.update_attributes(base_update_params)
      flash[:success] = "拠点情報を更新しました。"
      redirect_to user_bases_url
    else
      render '_edit'
    end
  end
  
  def destroy
    base = Base.find(params[:id])
    if base.destroy
      flash[:success] = "拠点情報を削除しました。"
      redirect_to user_bases_url
    end
  end
  
  private
  
    def base_update_params
      params.require(:base).permit(:base_number, :base_name, :attendance_type)
    end
end
