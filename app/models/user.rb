class User < ApplicationRecord

  #Associations
  has_many :wikis
  has_many :collaborators
  has_many :shared_wikis, through: :collaborators, source: :wiki

  #Callbacks
  after_initialize :init
  after_update :publicize, if: :downgraded?

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
      if self.saved_change_to_role?
        puts "User's role changed"
        true if self.saved_changes[:role][1].to_sym == :standard
      end
  end

  def publicize
      puts "Publicize previously-private Wikis"
      Wiki.where(user_id: self.id, private: true).update_all(private: false)
  end

end
