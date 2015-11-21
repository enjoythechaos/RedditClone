class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid username or password"]
      redirect_to new_sessions_url
    end
  end

  #only if person logged in
  def destroy
    log_out!
    redirect_to new_sessions_url
  end

end
