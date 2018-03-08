class User < ApplicationRecord

  has_many :wikis

  after_initialize :init
  after_update :check_private

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  #NL enables user.role, user.admin?, user.premium?, user.standard? (and current_user.admin? etc)
  enum role: [:standard, :premium, :admin]

private

  def init
    self.role ||= :standard
  end

  def check_private
    if self.standard?
      Wiki.where(user_id: self.id, private: true).update_all(private: false)
    end
  end

end
