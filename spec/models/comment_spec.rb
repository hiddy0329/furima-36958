require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメントの投稿' do
    context 'コメントが投稿できる場合' do
      it 'textが存在していれば投稿できる' do
        expect(@comment).to be_valid
      end
    end

    context 'コメントが投稿できない場合' do
      it 'textが空では出品できない' do
        @comment.text = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textを入力してください")
      end

      it 'ユーザーが紐付いていなければ出品できない' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Userを入力してください')
      end

      it '商品が紐付いていなければ出品できない' do
        @comment.item = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
