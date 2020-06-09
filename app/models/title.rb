class Title < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :vocabularies, dependent: :destroy
  has_many :users, through: :bookmarks
  has_many :bookmarks

  validates :name, presence: true
end
