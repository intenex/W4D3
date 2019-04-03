class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user
      redirect_to user_url(user)
    else
      flash[:errors] = 'Wrong credentials were input!'
      redirect_to new_session_url
    end
  end
end
