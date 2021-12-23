FactoryBot.define do
  factory :order_address do
    postal_code { "123-4567" }
    shipping_prefecture_id { 2 }
    shipping_municipality { "佐藤市田中区" }
    shipping_address { "山田1-1-1" }
    building_name { "アーバンプレイス伊藤202" }
    phone_number { "09012345678" }
    token { "tok_abcdefghijk00000000000000000" }
  end
end