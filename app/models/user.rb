class User < ActiveRecord::Base
    has_secure_password
    validates :username, presence: true, uniqueness: true, format: { with: /\w+/,
        message: 'Alphanumeric characters' }
    has_many :posts
    belongs_to :doctor
end