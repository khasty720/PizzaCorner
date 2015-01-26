class ProductPolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def update?
    @current_user.admin?
  end
  
  class Scope < Scope
    def resolve
      scope


    end
  end
end
