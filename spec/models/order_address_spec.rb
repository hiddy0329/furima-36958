require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空では保存できないこと' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが「3桁-4桁」のフォーマットでなければ保存できないこと' do
        @order_address.postal_code = '1111-222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが半角でなければ保存できないこと' do
        @order_address.postal_code = '１１１-２２２'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeがハイフンなしでは保存できないこと' do
        @order_address.postal_code = '1112222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'shipping_prefecture_idが空では保存できないこと' do
        @order_address.shipping_prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipping prefecture can't be blank")
      end
      it 'shipping_prefecture_idが1では保存できないこと' do
        @order_address.shipping_prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipping prefecture can't be blank")
      end
      it 'shipping_municipalityが空では保存できないこと' do
        @order_address.shipping_municipality = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipping municipality can't be blank")
      end
      it 'shipping_addressが空では保存できないこと' do
        @order_address.shipping_address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Shipping address can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンが含まれている状態では保存できないこと' do
        @order_address.phone_number = '09-12345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが全角では保存できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが全角では保存できないこと' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが9桁以下では保存できないこと' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが12桁以上では保存できないこと' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'tokenが空では保存できないこと' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'user_idが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('User must exist')
      end
      it 'item_idが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
