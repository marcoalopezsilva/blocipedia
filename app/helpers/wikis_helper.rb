module WikisHelper

  def user_can_edit?(record)
    #true if current_user.admin? || current_user.id == record.user_id || (current_user.id !=record.user_id && record.private == false)
    true if current_user.admin? || current_user.id == record.user_id || !record.private

  end

end
