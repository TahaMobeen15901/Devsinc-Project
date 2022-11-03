class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug
  def initialize(user,bug)
    @user = user
    @bug = bug
  end
  def index?
    true
  end
  def new?
    user.developer?
  end
  def create?
    user.developer?
  end
  def edit?
    user.developer?
  end
  def update?
    user.developer?
  end
  def destroy?
    user.developer?
  end
  def show?
    false
  end
end
