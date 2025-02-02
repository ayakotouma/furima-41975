FactoryBot.define do
  factory :purchase_form do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    address { '青山1-1-1' }
    building_name { nil }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' } # ← クレジット決済の実装が終わったら追加
  end
end
