class Post < ApplicationRecord
    validates :title, presence: true
    validates :kitchen_car_name, presence: true
    validates :body, presence: true, length: { maximum: 500 }

    belongs_to :user
end
