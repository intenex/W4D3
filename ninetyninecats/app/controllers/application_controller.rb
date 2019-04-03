class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!(current_user)
  end

  def check_login
    unless current_user
      redirect_to cats_url
    end
  end

  def login_user!(user)    
    if user
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      flash[:errors] = 'Wrong credentials were input!'
      redirect_to new_session_url
    end
  end

  def logout!
    user = current_user

    if user
      session[:session_token] = nil 
      user.reset_session_token!
      @current_user = nil
    end
  end
  
end
