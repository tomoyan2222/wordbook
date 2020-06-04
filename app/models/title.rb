class Title < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :vocabularies
end