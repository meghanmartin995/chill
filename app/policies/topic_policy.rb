class TopicPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index
    true
  end

   def new?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_creator?
  end

  def destroy?
    user_is_creator?
  end

  private

  def user_is_creator?
    record.user == user
  end
end
