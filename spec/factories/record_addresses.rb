FactoryBot.define do
  factory :record_address do
    postal_code        { '123-4567' }
    prefecture_id      {Prefecture.where.not(name: '---').sample.id}
    municipalities     { '東京都' }
    address            { '１−１−１' }
    building_name      { '東京ビル' }
    tel_num            {'09012345678'}
    token              { 'tok_abcdefghijk00000000000000000' }
  end
end