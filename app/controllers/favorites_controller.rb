class FavoritesController < ApplicationController
    before_action :logged_in_user
   
    def create 
        @micropost = Micropost.find(params[:favorite_id])
        # @favorite  = current_user.favorites.build(micropost: @micropost)
        current_user.favorite(@micropost)
        flash[:success] = "お気に入りに登録されました！"
        redirect_to :back
        # if @favorite.save
        #     redirect_to micropost_url(:user), notice: "お気に入りに登録しました"
        # else
        #     redirect_to micropost_url(:user), alert: "このツイートはお気に入りに登録できません"
        # end
    end
    
    def destroy
         f = Favorite.find(params[:id])
         f.destroy if f
      
        # @favorite = current_user.favorites.find_by!(micropost_id: params[:micropost_id])
        # @favorite.destroy
        # redirect_to micropost_url, notice: "お気に入りを解除しました"
    end
end
