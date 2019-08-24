class StaticPagesController < ApplicationController
  def home
    @user = User.new
  end

  def terms
  end
  
  private
  
end
