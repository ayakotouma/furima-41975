FactoryBot.define do
  factory :user do
    nickname { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
    password { 'password1' } # 半角英数字混合
    password_confirmation { password }
    last_name { '山田' } # 全角（漢字）
    first_name { '太郎' } # 全角（漢字）
    last_name_kana { 'ヤマダ' } # 全角（カタカナ）
    first_name_kana { 'タロウ' } # 全角（カタカナ）
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
