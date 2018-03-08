class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def downgrade
      Wiki.where(user_id: current_user.id, private: true).update_all(private: false)
      current_user.standard!
      flash[:sucess] = "Your account has been downgraded!"
      redirect_to request.referrer
  end

end
