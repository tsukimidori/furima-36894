require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できるとき' do
      it 'nickname・email・password(・_confirmation)・last_name(・_kana)・first_name(・_kana)・date_of_birthdayが正規表現を用いて存在している' do
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空のとき' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空のとき' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空のとき' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'password_confirmationが空のとき' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'last_nameが空のとき' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字を入力してください")
      end
      it 'first_nameが空のとき' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください")
      end
      it 'last_name_kanaが空のとき' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）を入力してください")
      end
      it 'first_name_kanaが空のとき' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください")
      end
      it 'date_of_birthdayが空のとき' do
        @user.date_of_birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'emailに@がないとき' do
        @user.email = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it 'emailが既に登録済みのものであったとき' do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it 'パスワードが6文字未満のとき' do
        @user.password = "qaz12"
        @user.password_confirmation = "qaz12"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it 'パスワードに半角英字しかないないとき' do
        @user.password = "qazwsx"
        @user.password_confirmation = "qazwsx"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードに半角数字しかないないとき' do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードに全角文字があるとき' do
        @user.password = "ｑazw12"
        @user.password_confirmation = "ｑazw12"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは半角英数字の両方を含めて入力してください")
      end
      it 'パスワードとパスワード（確認）の値が一致していないとき' do
        @user.password = "qaz123"
        @user.password_confirmation = "ujm789"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it 'お名前（全角）の苗字に全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.first_name = "Ｔ中"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'お名前（全角）の苗字に半角文字があるとき' do
        @user.first_name = "t中"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'お名前（全角）の名前に全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.last_name = "Ｔ郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'お名前（全角）の名前に半角文字があるとき' do
        @user.last_name = "t郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字は全角文字（漢字・ひらがな・カタカナ）で入力してください")
      end
      it 'お名前カナ（全角）の苗字に全角カタカナ以外の文字があるとき' do
        @user.first_name_kana = "タ中"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カタカナで入力してください")
      end
      it 'お名前カナ（全角）の苗字に半角文字があるとき' do
        @user.first_name_kana = "ﾀﾅｶ"
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）は全角カタカナで入力してください")
      end
      it 'お名前カナ（全角）の名前に全角カタカナ以外の文字があるとき' do
        @user.last_name_kana = "タ郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カタカナで入力してください")
      end
      it 'お名前カナ（全角）の名前に半角文字があるとき' do
        @user.last_name_kana = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("苗字（カナ）は全角カタカナで入力してください")
      end
    end
  end
end
