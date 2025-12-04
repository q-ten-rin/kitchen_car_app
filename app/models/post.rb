class Post < ApplicationRecord
  has_many_attached :images
  has_many :favorites, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  validates :title, presence: true
  validates :kitchen_car_name, presence: true
  validates :body, length: { maximum: 500 }

  belongs_to :user

  CATEGORIES = [
    "クレープ",
    "コーヒー",
    "ハンバーガー",
    "ピザ",
    "カレー",
    "タコス",
    "ラーメン",
    "スイーツ",
    "ドリンク",
    "その他"
  ]
end
