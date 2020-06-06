class Vocabulary < ApplicationRecord
  belongs_to :title

  WORD_FORMAT = /\A[a-zA-Z0-9]+\z/

  validates :word, presence: true, format: {with: WORD_FORMAT}
  validates :meaning, presence: true
end
