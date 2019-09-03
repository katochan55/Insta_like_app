class FavoritesController < ApplicationController
  before_action :logged_in_user

  # POST /favorites/:micropost_id/create
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @user = User.find(@micropost.user_id)
    current_user.favorite(@micropost)
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
    @user.notifications.create(content: "あなたの投稿が#{current_user.full_name}さんにお気に入り登録されました。")
  end

  # DELETE /favorites/:micropost_id/destroy
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    current_user.favorites.find_by(micropost_id: @micropost.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end
  
end