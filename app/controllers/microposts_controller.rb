class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user,   only: :destroy
  
  # GET /microposts
  def new
    @micropost = current_user.microposts.build if logged_in?
  end

  # POST /microposts
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿が完了しました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  # DELETE /microposts/:id
  def destroy
    @micropost.destroy
    flash[:success] = "投稿は削除されました"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id]) # 現在のユーザーが削除対象のマイクロポストを保有しているかどうか確認
      redirect_to root_url if @micropost.nil?
    end
    
end