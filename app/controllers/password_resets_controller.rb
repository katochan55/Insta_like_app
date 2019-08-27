class PasswordResetsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
  # GET /password_resets/:id/edit
  def edit
    #@user = User.find(params[:id]) => before_action :correct_userで定義済みのため省略
  end
  
  # PATCH /password_resets/:id
  def update
    #@user = User.find(params[:id]) => before_action :correct_userで定義済みのため省略
    if params[:user][:password].empty?
      # password欄が空だった場合
      @user.errors.add(:password, :blank)
    elsif correct_password_now?(@user) && correspond_new_password?
      # 現在のパスワードが一致し、かつ新しいパスワードとその確認も一致した場合
      @user.update_attributes(user_params_update)
      flash.now[:success] = "パスワードが変更されました！"
    else
      flash.now[:danger] = "現在のパスワード、あるいは新しいパスワードが異なっています。"
    end
    render 'edit' # Successの場合もFailureの場合もこの処理を行う
  end
  
  private
  
    # 「現在のパスワード」が合っているか確認
    def correct_password_now?(user)
      user.authenticate(params[:user][:password_now])
    end
    
    # 「新しいパスワード」と「新しいパスワードの確認」が一致しているか確認
    def correspond_new_password?
      params[:user][:password] == params[:user][:password_confirmation]
    end
  
    # パスワード変更時に許可する属性
    def user_params_update
      params.require(:user).permit(:password, :password_confirmation)
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
