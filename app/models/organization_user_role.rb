class OrganizationUserRole < ApplicationRecord
  belongs_to :role
  belongs_to :user
  belongs_to :organization
end
