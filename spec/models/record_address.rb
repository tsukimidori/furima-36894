require 'rails_helper'

RSpec.describe RecordAddress, type: :model do
  describe '購入履歴の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order = FactoryBot.build(:record_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '購入履歴の保存ができるとき' do
      it '全ての値が正しく入力されている場合' do
        expect(@order).to be_valid
      end
      it '建物名は値が入力されいなくても保存ができる' do
        @order.building_name = ''
        expect(@order).to be_valid
      end
    end

    context '購入履歴の保存ができないとき' do
      it 'userが紐付いていない場合' do
        @order.user_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていない場合' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Item can't be blank")
      end
      it 'token（クレカ情報）がない場合' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
      it '郵便番号の値が入力されていない場合' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code can't be blank")
      end
      it '都道府県の値が未選択（「---」を選択）の場合' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村の値が入力されていない場合' do
        @order.municipalities = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Municipalities can't be blank")
      end
      it '番地の値が入力されていない場合' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号の値が入力されていない場合' do
        @order.tel_num = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel num can't be blank")
      end
      it '郵便番号に半角数字以外で値を入力している場合' do
        @order.postal_code = 'abc-4567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号の値の桁数が間違っている場合' do
        @order.postal_code = '12-345678'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '郵便番号に-(ハイフン)なしで値を入力している場合' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end
      it '電話番号の桁数が10未満の場合' do
        @order.tel_num = '090123456'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel num is too short")
      end
      it '電話番号の桁数が12以上の場合' do
        @order.tel_num = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel num is too short")
      end
      it '電話番号に-(ハイフン)など半角数字以外の値を入力している場合' do
        @order.tel_num = '090-1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include("Tel num is invalid. Input only number")
      end
    end
  end
end