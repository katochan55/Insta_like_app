class SessionsController < ApplicationController

  # GET /login
  def new
  end
  
  # POST /login
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Success
      log_in user
      remember user
      redirect_back_or user
    else
      # Failure
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  # DELETE /logout
  def destroy
    log_out if logged_in?  # ログイン中のみログアウトすること(目立たないバグの修正)
    redirect_to root_url
  end

end
