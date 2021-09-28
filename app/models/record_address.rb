class RecordAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address, :building_name, :tel_num, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]\d{3}-[0-9]\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipalities
    validates :address
    validates :tel_num, format: {with: /\A\d{10,11}\z/, message: "is too short"}, numericality: { only_integer: true, message: "is invalid. Input only number"}
    validates :user_id
    validates :item_id
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building_name: building_name, tel_num: tel_num, purchase_record_id: purchase_record.id)
  end
end