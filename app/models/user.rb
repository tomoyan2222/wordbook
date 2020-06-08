class User < ApplicationRecord
    has_many :titles
    has_many :titles, through: :bookmarks
    has_many :follows
    has_many :followers, foreign_key: :follow_user_id, class_name: "Follow"
    
    has_secure_password

    validates :name, presence: true
    validates :original_name, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6}, allow_nil: true
end
