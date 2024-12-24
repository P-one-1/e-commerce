class OrganizationPolicy < ApplicationPolicy
    def index?
        user.present?
    end
  end