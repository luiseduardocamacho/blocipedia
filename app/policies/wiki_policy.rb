class WikiPolicy < ApplicationPolicy
  def update?
    #user.premium? or user.standard? or record.private == false or record.user == user
    !record.private or !(@user.standard?)
  end

  def edit?
    # user is the owner OK
    # public then ok
    # if private and user is the owner OK
    !record.private or !(@user.standard?)
  end

  def make_private?
    !(user.standard?) if user
  end
end
