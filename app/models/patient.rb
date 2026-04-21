class Patient < ApplicationRecord
  has_many :session_notes
end