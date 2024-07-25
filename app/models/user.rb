class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  validates :password, presence: true, if: :password_required?

  has_many :employees, class_name: 'User', foreign_key: 'manager_id'
  belongs_to :manager, class_name: 'User', optional: true

  enum role: { owner: 'owner', admin: 'admin', member: 'member' }

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= :member
  end

  def password_required?
    role != 'owner'
  end
end