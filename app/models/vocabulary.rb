class Vocabulary < ApplicationRecord
  belongs_to :title

  WORD_FORMAT = /\A[a-zA-Z0-9]/

  validates :word, presence: true, format: {with: WORD_FORMAT}, length: { maximum: 74 }
  validates :meaning, presence: true
end
