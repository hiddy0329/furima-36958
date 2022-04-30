class Item < ApplicationRecord
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
  
  has_one :order
  belongs_to :user
  has_many_attached :images
  validates :images, presence: { message: "を選択してください" }
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :postage
  belongs_to :region
  belongs_to :shipping_date
end
