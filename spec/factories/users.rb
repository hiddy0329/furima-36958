FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname { person }
    email { Faker::Internet.free_email }
    password = Faker::Internet.password(min_length: 6, mix_case: true)
    password { password }
    password_confirmation { password }
    last_name { person.last.kanji }
    first_name { person.first.kanji }
    last_name_kana { person.last.katakana }
    first_name_kana { person.first.katakana }
    birthday { Faker::Date.in_date_period }
  end
end
