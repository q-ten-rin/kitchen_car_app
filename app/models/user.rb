class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    
    has_many :posts, dependent: :destroy

    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
