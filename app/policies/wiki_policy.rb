class WikiPolicy < ApplicationPolicy

    # It is not necessary to use "current_user" here because Pundit uses 'current_user' to get 'user'.
    # So, we can simply refer to 'user'
    # Also, wen the methods refer to 'record', Pundit uses the object that the HTML refers to
    def destroy?
        #true if user.admin? || user.id == record.user_id
        user.admin? || user.id == record.user_id
    end

    def update?
        #true if record.private == false || record.private == true && user.id == record.user_id || user.admin?
        record.private == false || record.private && user.id == record.user_id || user.admin?
    end

    def view_private?
        user.admin? || ( user.premium? && user.id == record.user_id )
    end
end
