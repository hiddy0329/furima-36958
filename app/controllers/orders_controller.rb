class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_order_and_user, only: :index
  before_action :set_item, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :shipping_prefecture_id, :shipping_municipality, :shipping_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def check_order_and_user
    @item = Item.find(params[:item_id])
    if current_user.id != @item.user_id && @item.order.present?
      redirect_to root_path
    elsif current_user.id == @item.user_id 
      redirect_to root_path
    else
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

end
