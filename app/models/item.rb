class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :item_name,          presence: true
  validates :item_text,          presence: true
  validates :category_id,        presence: true
  validates :item_status_id,     presence: true
  validates :shipping_charge_id, presence: true
  validates :prefecture_id,      presence: true
  validates :required_day_id,    presence: true
  validates :price,              presence: true

  belongs_to :user
  has_one_attached :image
  belongs_to :category, :item_status, :shipping_charge, :prefecture, :required_day
end
