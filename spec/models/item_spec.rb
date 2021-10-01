require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できるとき' do
      it '商品画像、商品名、商品の説明、商品の詳細、配送について、販売価格を正規表現を用いて入力したとき' do
        expect(@item).to be_valid
      end
    end
    context '商品を出品できないとき' do
      it 'userが紐づいていないとき' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("ユーザー（出品者）を入力してください")
      end
      it '商品画像がアップロードされていないとき' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像を入力してください")
      end
      it '商品名が入力されていないとき' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it '商品の説明が入力されていないとき' do
        @item.item_text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it '商品の詳細・カテゴリーが未選択（「---」を選択）のとき' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
      end
      it '商品の詳細・商品の状態が未選択（「---」を選択）のとき' do
        @item.item_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選択してください")
      end
      it '配送について・配送料の負担が未選択（「---」を選択）のとき' do
        @item.shipping_charge_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
      end
      it '配送について・発送元の地域が未選択（「---」を選択）のとき' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
      end
      it '配送について・発送までの日数が未選択（「---」を選択）のとき' do
        @item.required_day_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
      end
      it '販売価格が入力されていないとき' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it '販売価格に半角数字以外の文字を入力したとき' do
        @item.price = '５００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください")
      end
      it '販売価格に¥300未満の値を入力したとき' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が価格制限の範囲外です")
      end
      it '販売価格に¥9,999,999以上の値を入力したとき' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格が価格制限の範囲外です")
      end
    end
  end
end
