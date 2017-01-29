class RelationshipsController < ApplicationController
  before_action :logged_in_user
  def create
    @user = User.find(params[:followed_id])  # Userモデルの中からparams[:followed_id]を持つレコードを取得  
                                             # (フォローする他のユーザーのIDをパラメータとして受け取り)
    current_user.follow(@user)               # 現在ログインしているユーザーが見つかったユーザーを引数としてUserモデルのfollowメソッドを実行
                                             # helpers/sessions_helper.rbにてcurrent_user(メソッド)を定義
                                             # application_controller.rbにて”include SessionsHelper”としているので、全てのcontrollerで使用可
  end

  # def destroy
  #   r = Relationship.find(params[:id])       
  #   r.destroy if r
    # @user = current_user.following_relationships.find(params[:id]).followed
    # current_user.unfollow(@user)
  #end
  def destroy
    @user = current_user.following_relationships.find(params[:id]).followed
    current_user.unfollow(@user)
  end
end
