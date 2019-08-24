class UsersController < ApplicationController
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
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end

  private
  
    def user_params
      params.require(:user).permit(:full_name, :user_name, :email,
                                   :password, :password_confirmation)
    end
  
end
