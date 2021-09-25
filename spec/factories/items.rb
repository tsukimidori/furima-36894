FactoryBot.define do
  factory :item do
    item_name          {Faker::Lorem.word}
    item_text          {Faker::Lorem.sentence}
    category_id        {Category.where.not(name: '---').sample.id}
    item_status_id     {ItemStatus.where.not(name: '---').sample.id}
    shipping_charge_id {ShippingCharge.where.not(name: '---').sample.id}
    prefecture_id      {Prefecture.where.not(name: '---').sample.id}
    required_day_id    {RequiredDay.where.not(name: '---').sample.id}
    price              {Faker::Number.within(range: 300..9_999_999)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
