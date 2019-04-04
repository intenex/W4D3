class UsersController < ApplicationController
  before_action :unless_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
    else
      render json: @user.errors.full_messages, status: 422 
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

# User.new will iterate over the options hash
# options_hash = {username: "auser", password: "hunter12", hello: "rand_value"}
# a = User.new
# a.username = "auser"
# a.password = "hunter12"
# a.hello = "rand_value"