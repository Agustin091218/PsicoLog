class Patient < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  has_many :notes

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
