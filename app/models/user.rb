class User < ApplicationRecord
  validates :name, presence: true 
  validates :email, presence: true, uniqueness: true
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
    
  has_many :posts, dependent: :destroy
  has_one_attached :avatar

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def favorite(post)
    favorite_posts << post
  end
  
  def unfavorite(post)
    favorite_posts.destroy(post)
  end
  
  def favorite?(post)
    favorite_posts.include?(post)
  end  
end
