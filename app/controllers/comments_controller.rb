class CommentsController < ApplicationController
  before_action :logged_in_user

  # POST /comments
  # params[:comment][:content], current_user
  def create
    @micropost = Micropost.find(params[:micropost_id])
    @user = User.find(@micropost.user_id)
    @comment = @micropost.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@micropost.nil? && @comment.save
      flash[:success] = "コメントを投稿しました！"
      @user.notifications.create(micropost_id: @micropost.id,
                                 content: "あなたの投稿に#{current_user.full_name}さんがコメントしました。")
      $NOTIFICATION_FLAG = 1
    else
      flash[:danger]  = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end
      
end