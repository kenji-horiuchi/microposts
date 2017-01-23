class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
 
  def index
   @users = User.page(params[:page]).per(10).order(:id)
  end
  def show 
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
  
  def followings
      @user  = User.find(params[:id])  #　あるユーザーを取得する(@user)
      @users = @user.following_users   #  あるユーザーがフォローしているユーザーを取得し、インスタンス変数(@users)に代入する
      render 'show_followings'
  end

  def followers
      @user  = User.find(params[:id])  #　あるユーザーを取得する(@user)
      @users = @user.follower_users    #　あるユーザーをフォローしているユーザーを取得し、インスタンス変数(@users)に代入する
      render 'show_followers'
  end
  
  def favorites
      @user  = User.find(params[:id])  #　あるユーザーを取得する(@user)
      #@favorites = @user.favorites     #　あるユーザーのお気に入りしている投稿一覧を取得し、インスタンス変数(@microposts)に代入する
      @microposts = @user.favorite_microposts
      render 'favorites'
  end
  
  #def microposts
  #    @user  = User.find(params[:id])  
  #    @favorites = @user.favorites     
  #    render 'favorites'
  #end
  
  #　コントローラアクションのデバックの方法
  #def favorites
  #  logger.debug("<<<<<")
  #  logger.debug("ID: " + params[:id])
  #  logger.debug("User")
  #    @user = User.find(params[:id])
  #  logger.debug(@user)
  #  logger.debug("Favorites")
  #    @favorites = @user.favorites
  #  logger.debug(@favorites)
  #    render 'favorites'
  #end

  private

  def user_params
    params.require(:user).permit(:name, :email, :area, :age, :password,
                                 :password_confirmation, :image)
  end
  
  def correct_user
    # 自分＝current_user
    # 編集対象のユーザー=@user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end
  
end
