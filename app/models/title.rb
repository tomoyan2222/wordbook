class Title < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :vocabularies, dependent: :destroy

  validates :name, presence: true
end
