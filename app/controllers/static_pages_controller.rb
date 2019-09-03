class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @user = current_user
      @feed_items = current_user.feed.paginate(page: params[:page])
      @comment = Comment.new
    else
      @user = User.new
    end
  end

  def terms
  end
  
  private
  
end
