class ApplicationController < ActionController::Base

  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    # for multiple sessions, change to
    # @current_user ||= Session.find_by(session_token: session[:session_token]).user
    # Session is a model for all our sessions, with columns session_token, user_id
    # it has a association belongs_to :user, class_name: :User, foreign_key: :user_id
  end

  def logged_in?
    !!(current_user)
  end

  def unless_logged_in
    if current_user
      redirect_to cats_url
    end
  end

  def only_if_logged_in
    unless current_user
      redirect_to cats_url
    end
  end

  def login_user!(user)    
    if user
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      flash[:errors] = ['Wrong credentials were input!']
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
