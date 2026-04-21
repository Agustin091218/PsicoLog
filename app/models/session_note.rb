class SessionNote < ApplicationRecord
  belongs_to :patient
  validates :content, presence: true
end