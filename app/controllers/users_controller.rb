class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def downgrade
      current_user.standard!
      flash[:sucess] = "Your account has been downgraded!"
      redirect_to request.referrer
  end

end
