class ProductPolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    admin? 
  end

  def create?
    admin?
  end

  def bulk_create?
    admin?
  end

  private

  def admin?
    user.present? && user.organization_user_role_ids.include?(Role.find_by(name: 'admin').id)
  end
end
