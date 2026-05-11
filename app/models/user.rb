class User < ApplicationRecord
  include SoftDeletable

  has_secure_password

  has_many :patients
  has_many :notes, through: :patients

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false, conditions: -> { where(deleted_at: nil) } }

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
