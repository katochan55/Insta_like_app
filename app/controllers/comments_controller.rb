class CommentsController < ApplicationController
  before_action :logged_in_user

  # POST /comments
  # params[:comment][:content], current_user
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@micropost.nil? && @comment.save
      flash[:success] = "コメントを投稿しました！"
    else
      flash[:danger]  = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer
  end
      
end