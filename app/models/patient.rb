class Patient < ApplicationRecord
  include SoftDeletable

  belongs_to :user
  has_many :notes

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user notes]
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
