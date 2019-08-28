class Api::V1::DocumentPolicy < ApplicationPolicy
  def create?
    return true
  end

  def create_pdf?
    return true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
