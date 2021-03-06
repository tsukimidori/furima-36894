class RecordAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address, :building_name, :tel_num, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "は例のように入力してください (例：123-4567)"}
    validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }
    validates :municipalities
    validates :address
    validates :tel_num, format: {with: /\A\d{10,11}\z/, message: "は10~11桁で入力してください"}, numericality: { only_integer: true, message: "は半角数字のみで入力してください"}
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase_record = PurchaseRecord.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building_name: building_name, tel_num: tel_num, purchase_record_id: purchase_record.id)
  end
end