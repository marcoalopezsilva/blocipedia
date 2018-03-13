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

    #---- Pundit's scope
    class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       wikis = []
       if user.admin?
         wikis = scope.all # if the user is an admin, show them all the wikis
     elsif user.premium?
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.user_id == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.private == false || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end

end
