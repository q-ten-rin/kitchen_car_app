class Post < ApplicationRecord
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
