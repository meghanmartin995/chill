class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    user_is_creator?
  end

  private

  def user_is_creator?
    record.user == user
  end
end
