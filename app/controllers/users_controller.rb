class UsersController < ApplicationController

  def new
    @user = User.new
  end

=begin
  def create
    @user = User.new
    @user.email = params[:user][:email]
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
        flash[:notice] = "Welcome to Blocipedia, #{@user.email}!"
        create_session(@user)
        redirect_to root_path
    else
        flash.now[:alert] = "There was an error creating your account. Please try again."
        render :new
    end
  end
=end
  
end
