FactoryBot.define do
  factory :post do
    title { "テスト投稿" }
    body  { "テスト本文" }
    kitchen_car_name { "キッチンカー" }

    association :user
    association :category
  end
end
