class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
  end
  
  # GET /users/:id
  def show
    @user = User.find(params[:id])
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
      flash[:success] = "Welcome to the Instagram!"
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

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
end
