class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_item_and_user, only: [:edit, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
  end

  def edit
    # attributesメソッドで属性値をハッシュ形式で取得する
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
  end

  def update
    # ユーザーが編集後の内容をバリデーションにかけるため、新たにインスタンスを生成する
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid? 
      @item_form.update(item_form_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_form_params
    params.require(:item_form).permit(:name, :description, :category_id, :state_id, :postage_id, :region_id, :shipping_date_id,
                  :price, {images: []}).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def check_item_and_user
    if current_user.id != @item.user_id || @item.order.present?
      redirect_to root_path
    end
  end
  
end
