class FavoritesController < ApplicationController
    before_action :logged_in_user
   
    def create 
        @micropost = Micropost.find(params[:micropost_id])  # Micropostモデルからmicropost_idがキーになっている値を取得し、インスタンス変数(@micropost)に代入
        current_user.favorite(@micropost)                  # @micropostの中から現在のユーザーがお気に入りを登録
        #flash[:success] = "お気に入りに登録されました！"
        #redirect_to :back
    end
    def destroy
        @micropost = Micropost.find(params[:micropost_id])
        #current_user.unfavorite(@micropost)
         f = Favorite.find(params[:id])                    # (Favoriteモデルから)あるお気に入りを取得(f)
         f.destroy if f                                    # fが存在している場合、fを削除 
    end
end
