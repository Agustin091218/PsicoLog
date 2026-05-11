class Note < ApplicationRecord
  include SoftDeletable

  NOTE_TYPES = %w[session_note general_note quick_note].freeze

  belongs_to :patient

  validates :patient_id, presence: true
  validates :note_type, presence: true, inclusion: { in: NOTE_TYPES }
  validates :recorded_at, presence: true
  validates :content, presence: true

  scope :ordered, -> { order(recorded_at: :desc) }

  def self.note_types
    NOTE_TYPES
  end
end
