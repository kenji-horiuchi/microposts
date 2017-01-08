class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def show # 追加
   @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :area, :age, :password,
                                 :password_confirmation)
  end
  
  def correct_user
    # 自分＝current_user
    # 編集対象のユーザー=@user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
  
end
