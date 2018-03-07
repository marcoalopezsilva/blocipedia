class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def downgrade
      private_wikis_to_convert = Wiki.where(user_id: current_user.id, private: true)
      private_wikis_to_convert.each do |item|
          item.private = false
          item.save
      end
      current_user.standard!
      flash[:sucess] = "Your account has been downgraded!"
      redirect_to request.referrer
  end

end
