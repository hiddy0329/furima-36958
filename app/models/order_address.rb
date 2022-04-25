class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_prefecture_id, :shipping_municipality, :shipping_address, :building_name, :phone_number, :item_id, :user_id, :token
  
  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "をハイフン(-)を含めて正しく入力してください"}
    validates :shipping_municipality
    validates :shipping_address
    validates :phone_number,format: { with: /\A[0-9]{10,11}\z/}
    validates :token
  end
  validates :shipping_prefecture_id, numericality: {other_than: 1, message: "を選択してください"}
  validates :user_id, presence: {message: "must exist"}
  validates :item_id, presence: {message: "must exist"}
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, shipping_prefecture_id: shipping_prefecture_id, shipping_municipality: shipping_municipality, shipping_address: shipping_address, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
