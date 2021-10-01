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
        expect(@order.errors.full_messages).to include("ユーザー（購入者）を入力してください")
      end
      it 'itemが紐付いていない場合' do
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("商品を入力してください")
      end
      it 'token（クレカ情報）がない場合' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '郵便番号の値が入力されていない場合' do
        @order.postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号を入力してください")
      end
      it '都道府県の値が未選択（「---」を選択）の場合' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include("都道府県を選択してください")
      end
      it '市区町村の値が入力されていない場合' do
        @order.municipalities = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("市区町村を入力してください")
      end
      it '番地の値が入力されていない場合' do
        @order.address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("番地を入力してください")
      end
      it '電話番号の値が入力されていない場合' do
        @order.tel_num = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号を入力してください")
      end
      it '郵便番号に半角数字以外で値を入力している場合' do
        @order.postal_code = 'abc-4567'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は例のように入力してください (例：123-4567)")
      end
      it '郵便番号の値の桁数が間違っている場合' do
        @order.postal_code = '12-345678'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は例のように入力してください (例：123-4567)")
      end
      it '郵便番号に-(ハイフン)なしで値を入力している場合' do
        @order.postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include("郵便番号は例のように入力してください (例：123-4567)")
      end
      it '電話番号の桁数が10未満の場合' do
        @order.tel_num = '090123456'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は10~11桁で入力してください")
      end
      it '電話番号の桁数が12以上の場合' do
        @order.tel_num = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は10~11桁で入力してください")
      end
      it '電話番号に-(ハイフン)など半角数字以外の値を入力している場合' do
        @order.tel_num = '090-1234-5678'
        @order.valid?
        expect(@order.errors.full_messages).to include("電話番号は半角数字のみで入力してください")
      end
    end
  end
end