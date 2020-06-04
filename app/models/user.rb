class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates :original_name, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6}, allow_nil: true
end
