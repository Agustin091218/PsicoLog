class Patient < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  def soft_delete
    return if deleted?

    update!(deleted_at: Time.current)
  end

  def restore
    return unless deleted?

    update!(deleted_at: nil)
  end

  def deleted?
    deleted_at.present?
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
