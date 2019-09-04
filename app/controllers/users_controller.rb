class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  # before_action :admin_user,     only: :destroy
  
  # GET /users
  def index
    @users = User.paginate(page: params[:page])
  end
  
  # GET /users/:id
  def show
    # 後ほど、横三列の写真表示に変更する
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  # GET /signup
  def new
    @user = User.new
  end
  
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      # Success
      log_in @user
      flash[:success] = "Instagramへようこそ!"
      redirect_to @user
    else
      # Failure
      render 'new'
    end
  end
  
  # GET /users/:id/edit
  def edit
    #@user = User.find(params[:id]) => before_action :correct_userで定義済みのため省略
  end
  
  # PATCH /users/:id
  def update
    #@user = User.find(params[:id]) => before_action :correct_userで定義済みのため省略
    if @user.update_attributes(user_params_update)
      # Success
      flash[:success] = "プロフィールが保存されました！"
      redirect_to @user
    else
      # Failure
      render 'edit'
    end
  end
  
  # DELETE /users/:id
  def destroy
    @user = User.find(params[:id])
    # ユーザー一覧ページの「削除」リンクがクリックされた場合
    if request.referrer == users_url
    # if request.original_fullpath == user_path(id: params[:id])
      if current_user.admin?
        @user.destroy
        flash[:success] = "ユーザーの削除に成功しました。"
        redirect_to users_url
      else
        redirect_to root_url
      end
    # プロフィール編集ページの「アカウントを削除する」リンクがクリックされた場合
    elsif request.referrer == edit_user_url
      if current_user?(@user)
        @user.destroy
        flash[:success] = "アカウントを削除しました。"
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end
  
  # def destroy
  #   User.find(params[:id]).destroy
  #   flash[:success] = "ユーザーの削除に成功しました。"
  #   redirect_to users_url
  # end
  
  def following
    @title1 = "フォローしているユーザー一覧"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title1 = "フォロワー一覧"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  
    # ユーザー新規作成時に許可する属性
    def user_params
      params.require(:user).permit(:full_name, :user_name, :email,
                                   :password, :password_confirmation)
    end
    
    # プロフィール編集時に許可する属性
    def user_params_update
      params.require(:user).permit(:full_name, :user_name, :website, :introduction,
                                   :email, :phone_number, :sex)
    end
    
    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end
