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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空のとき' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空のとき' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'password_confirmationが空のとき' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが空のとき' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name is invalid. Input full-width characters")
      end
      it 'first_nameが空のとき' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid. Input full-width characters")
      end
      it 'last_name_kanaが空のとき' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana is invalid. Input full-width katakana characters")
      end
      it 'first_name_kanaが空のとき' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid. Input full-width katakana characters")
      end
      it 'date_of_birthdayが空のとき' do
        @user.date_of_birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Date of birthday can't be blank")
      end
      it 'emailに@がないとき' do
        @user.email = "testtest"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'emailが既に登録済みのものであったとき' do
        user2 = FactoryBot.create(:user)
        @user.email = user2.email
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it 'パスワードが6文字未満のとき' do
        @user.password = "qaz12"
        @user.password_confirmation = "qaz12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'パスワードに半角英字しかないないとき' do
        @user.password = "qazwsx"
        @user.password_confirmation = "qazwsx"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードに半角数字しかないないとき' do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードに全角文字があるとき' do
        @user.password = "ｑazw12"
        @user.password_confirmation = "ｑazw12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'パスワードとパスワード（確認）の値が一致していないとき' do
        @user.password = "qaz123"
        @user.password_confirmation = "ujm789"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前（全角）の苗字に全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.first_name = "Ｔ中"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'お名前（全角）の苗字に半角文字があるとき' do
        @user.first_name = "t中"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid. Input full-width characters")
      end
      it 'お名前（全角）の名前に全角漢字・ひらがな・カタカナ以外があるとき' do
        @user.last_name = "Ｔ郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it 'お名前（全角）の名前に半角文字があるとき' do
        @user.last_name = "t郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name is invalid. Input full-width characters")
      end
      it 'お名前カナ（全角）の苗字に全角カタカナ以外の文字があるとき' do
        @user.first_name_kana = "タ中"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it 'お名前カナ（全角）の苗字に半角文字があるとき' do
        @user.first_name_kana = "ﾀﾅｶ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid. Input full-width katakana characters")
      end
      it 'お名前カナ（全角）の名前に全角カタカナ以外の文字があるとき' do
        @user.last_name_kana = "タ郎"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'お名前カナ（全角）の名前に半角文字があるとき' do
        @user.last_name_kana = "ﾀﾛｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
    end
  end
end
