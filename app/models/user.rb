class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname,         presence: true
  validates :last_name,        presence: true
  validates :first_name,       presence: true
  validates :last_name_kana,   presence: true
  validates :first_name_kana,  presence: true
  validates :date_of_birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は半角英数字の両方を含めて入力してください'

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角文字（漢字・ひらがな・カタカナ）で入力してください'} do
    validates :first_name
    validates :last_name
  end

  with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください'} do
    validates :first_name_kana
    validates :last_name_kana
  end

  has_many :items
  has_many :purchase_records
end
