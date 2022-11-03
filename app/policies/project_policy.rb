








class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project
  def initialize(user,project)
    @user = user
    @project = project
  end
  def index?
    true
  end
  def new?
    user.manager?
  end
  def create?
    user.manager?
  end
  def edit?
    user.manager?
  end
  def update?
    user.manager?
  end
  def destroy?
    user.manager?
  end
  def show?
    user.developer?
  end
end
