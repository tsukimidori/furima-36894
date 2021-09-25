class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :image,              presence: true
  validates :item_name,          presence: true
  validates :item_text,          presence: true
  validates :category_id,        presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :item_status_id,     presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_charge_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :prefecture_id,      presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :required_day_id,    presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :price,              presence: true

  belongs_to :user
  has_one_attached :image
  belongs_to :category, :item_status, :shipping_charge, :prefecture, :required_day

  with_options format: { with: /\A[0-9]+\d\z/, message: "is invalid. Input half-width characters"} do
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: "is out of setting range"}
  end
end