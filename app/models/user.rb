class User < ApplicationRecord

  has_many :wikis

  after_initialize :init

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  #NL enables user.role, user.admin?, user.premium?, user.standard? (and current_user.admin? etc)
  enum role: [:standard, :premium, :admin]

  def init
    self.role ||= :standard
  end

end
