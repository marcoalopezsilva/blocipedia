class User < ApplicationRecord

  has_many :wikis

  after_initialize :init
  before_update :publicize, if: :downgraded?

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

  def downgraded?
      self.will_save_change_to_role?(from: :premium, to: :standard)
  end

  def publicize
      Wiki.where(user_id: self.id, private: true).update_all(private: false)
  end

end
