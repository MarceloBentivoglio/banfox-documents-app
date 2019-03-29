class DocumentPolicy < ApplicationPolicy
  def show?
    return true
  end

  def download?
    return true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
