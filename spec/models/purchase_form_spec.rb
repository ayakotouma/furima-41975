require 'rails_helper'

RSpec.describe PurchaseForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_form = FactoryBot.build(:purchase_form, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do
    context '購入が成功する場合' do
      it 'すべての情報が正しく入力されていれば購入できる' do
        expect(@purchase_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @purchase_form.building_name = ''
        expect(@purchase_form).to be_valid
      end
    end

    context '購入が失敗する場合' do # クレジットカードの実装後に復活させる
      it 'クレジットカード情報が空だと購入できない' do
        @purchase_form.token = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空だと購入できない' do
        @purchase_form.postal_code = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が「3桁-4桁」でないと購入できない' do
        @purchase_form.postal_code = '1234567'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Postal code is invalid. Enter it as 123-4567')
      end

      it '都道府県が選択されていないと購入できない' do
        @purchase_form.prefecture_id = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空だと購入できない' do
        @purchase_form.city = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空だと購入できない' do
        @purchase_form.address = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空だと購入できない' do
        @purchase_form.phone_number = ''
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満だと購入できない' do
        @purchase_form.phone_number = '123456789'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter it without hyphens')
      end

      it '電話番号が12桁以上だと購入できない' do
        @purchase_form.phone_number = '123456789012'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter it without hyphens')
      end

      it '電話番号にハイフンが含まれていると購入できない' do
        @purchase_form.phone_number = '090-1234-5678'
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include('Phone number is invalid. Enter it without hyphens')
      end

      it 'tokenが空では登録できないこと' do
        @purchase_form.token = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'user_idが空だと登録できない' do
        @purchase_form.user_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空だと登録できない' do
        @purchase_form.item_id = nil
        @purchase_form.valid?
        expect(@purchase_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
