class ItemForm
  include ActiveModel::Model
  attr_accessor :name, :description, :category_id, :state_id, :postage_id, :region_id, :shipping_date_id, :price, :user_id, :images

  validates :name,             presence: true
  validates :description,      presence: true
  validates :category_id,      numericality: { other_than: 1, message: "を選択してください" }
  validates :state_id,         numericality: { other_than: 1, message: "を選択してください" }
  validates :postage_id,       numericality: { other_than: 1, message: "を選択してください" }
  validates :region_id,        numericality: { other_than: 1, message: "を選択してください" }
  validates :shipping_date_id, numericality: { other_than: 1, message: "を選択してください" }

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      presence: { message: "を入力してください" }
  end

  validates :images, presence: { message: "を選択してください" }
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  validates :user_id

  def save
    Item.create(name: name, description: description, category_id: category_id, state_id: state_id, 
                postage_id: postage_id, region_id: region_id, shipping_date_id: shipping_date_id, price: price, user_id: user_id, images: images)
  end
end