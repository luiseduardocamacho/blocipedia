class UserPolicy < ApplicationPolicy

  def show?
    user.id == record.id
  end

  def premium_list?
    user.premium?
  end

end
