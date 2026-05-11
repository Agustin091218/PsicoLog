class Note < ApplicationRecord
  include SoftDeletable

  NOTE_TYPES = %w[session_note initial_interview follow_up emergency discharge general_note quick_note].freeze

  belongs_to :patient

  validates :patient_id, presence: true
  validates :note_type, presence: true, inclusion: { in: NOTE_TYPES }
  validates :recorded_at, presence: true
  validates :content, presence: true

  scope :ordered, -> { order(recorded_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[content note_type recorded_at created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[patient]
  end

  def self.note_types
    NOTE_TYPES
  end

  def self.translated_types
    NOTE_TYPES.map { |t| [I18n.t("note_types.#{t}"), t] }
  end

  def translated_type
    I18n.t("note_types.#{note_type}")
  end
end
