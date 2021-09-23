FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password = Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1)
    password              {password}
    password_confirmation {password}
    last_name             {"鳥"}
    first_name            {"月見"}
    last_name_kana        {"ドリ"}
    first_name_kana       {"ツキミ"}
    date_of_birthday      {"2000-10-15"}
  end
end