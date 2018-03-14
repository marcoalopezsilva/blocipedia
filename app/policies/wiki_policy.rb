class WikiPolicy < ApplicationPolicy

    # It is not necessary to use "current_user" here because Pundit uses 'current_user' to get 'user'.
    # So, we can simply refer to 'user'
    # Also, wen the methods refer to 'record', Pundit uses the object that the HTML refers to
    def destroy?
        #Only admin users, or a wiki's original creator, will be able to destroy it
        user.admin? || user.id == record.user_id
    end

    def update?
      #This is because the scope already shows the user only those private Wikis  which she is authorized to see (and, therefore, edit)
      true
    end

    #---- Pundit's scope
    class Scope

      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      def resolve
        if @user.admin?
          #Show all wikis to admins
          return @scope.all
        elsif @user.premium?
          #To premium users, show: their own wikis, plus public wikis which are not theirs (to avodi duplicating)
          return @scope.where(user_id: @user.id) + @scope.where(private: false).where.not(user_id: @user.id)
        elsif @user.standard?
          #To standard users, show: wikis in which they are collaborators, plus any public wikis
          return @scope.joins(:collaborators).where(collaborators: {user_id: @user.id}) + @scope.where(private: false)
        else
          return @scope.none
        end
      end

    end

end
