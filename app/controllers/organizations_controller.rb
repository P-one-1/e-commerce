class OrganizationsController < ApplicationController
  before_action :user_present?

  def index
    ids = current_user.organization_user_roles.pluck(:organization_id)
    @organizations = Organization.where(id: ids)
    authorize @organizations
  end

  private

  def user_present?
    redirect_to new_user_session_path if current_user.nil?
  end
end
