class BattlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def battlepage?
    return true
  end

  def apitest?
    return true
  end

  def showmovies?
    return true
  end

  def show?
    return true
  end

  def create?
    return true
  end

  def update?
    return true
  end

  def destroy?
    return true
  end
end
