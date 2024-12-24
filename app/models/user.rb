class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :organization_user_roles
  has_many :organizations, through: :organization_user_roles
  has_many :roles, through: :organization_user_roles
end
