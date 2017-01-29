class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build                                                                 # ログインしている場合、userの投稿を作成する(@micropost)
      # current_user.microposts.buildはMicropost.new(user_id: current_user.id)と同じ
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)  
    end
  end
end
