FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name } # ランダムな商品名を生成
    description { Faker::Lorem.sentence } # ランダムな説明文を生成
    category_id { Faker::Number.between(from: 2, to: 10) } # カテゴリーIDの範囲を設定 (ActiveHashに合わせる)
    condition_id { Faker::Number.between(from: 2, to: 6) } # 商品の状態IDの範囲を設定
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) } # 配送料の負担ID
    prefecture_id { Faker::Number.between(from: 2, to: 48) } # 都道府県ID
    shipping_day_id { Faker::Number.between(from: 2, to: 4) } # 発送までの日数ID
    price { Faker::Number.between(from: 300, to: 9_999_999) } # 価格の範囲
    association :user # ユーザーと関連付け

    after(:build) do |item|
      item.image.attach(
        io: File.open('public/images/test_image.png'),
        filename: 'test_image.png'
      )
    end
  end
end
