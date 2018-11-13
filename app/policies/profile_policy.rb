class ProfilePolicy < ApplicationPolicy
  def show?
    return true
  end

  def create?
    if record.user == user?
      return true
    end
  end

  def update?
    if record.user == user?
      return true
    end
  end

  def destroy?
    if record.user == user?
      return true
    end
  end
end
