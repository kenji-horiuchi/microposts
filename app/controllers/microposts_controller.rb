class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
  
  def show 
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
      # feed_items＝Userモデルで定義したメソッド、includes＝関連するテーブルをまとめて取得
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])                    # 現在のユーザーの全投稿の中からある投稿を取得し、インスタンス変数(@micropost)に代入
    return redirect_to root_url if @micropost.nil?                                   # @micropostが存在しない場合、root_urlにリダイレクト
    # if @micropost.ni?                                                              # redirect_toがメソッド内に２回出てくる場合、１回目はreturnをつけないとエラーになる
    #    return redirect_to root_url
    # end                             を短縮した形
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url                                         # ||＝または、request.refferer＝遷移元のURLを取得
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end
end
