class SessionsController < ApplicationController
  before_action :unless_logged_in, only: [:new]
  
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    login_user!(user)
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end
