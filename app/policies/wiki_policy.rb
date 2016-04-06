class WikiPolicy < ApplicationPolicy
  def update?
    #user.premium? or user.standard? or record.private == false or record.user == user
    record.private == false or @record.user == user
  end
end
