class WikiPolicy < ApplicationPolicy
  def update?
    #user.premium? or user.standard? or record.private == false or record.user == user
    !record.private or !(@user.standard?) or @user.wiki_collaborations.present?
  end

  def edit?
    # user is the owner OK
    # public then ok
    # if private and user is the owner OK
    !record.private or !(@user.standard?) or @user.wiki_collaborations.present?
  end

  def show?
    !record.private or !(@user.standard?) or @user.wiki_collaborations.present?
  end

  def make_private?
    !(user.standard?) if user
  end

  class Scope
       attr_reader :user, :scope

       def initialize(user, scope)
         @user = user
         @scope = scope
       end

       def resolve
         wikis = []
         if user && user.role == 'admin'
           wikis = scope.all # if the user is an admin, show them all the wikis
         elsif user && user.role == 'premium'
           all_wikis = scope.all
           all_wikis.each do |wiki|
             if !wiki.private? || wiki.user == user || wiki.collaborators.include?(user)
               wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
             end
           end
         else # this is the lowly standard user
           all_wikis = scope.all
           wikis = []
           all_wikis.each do |wiki|
             if !wiki.private? || wiki.collaborators.include?(user)
               wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
             end
           end
         end
         wikis # return the wikis array we've built up
       end
     end
   end

#end
