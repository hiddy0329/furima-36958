class Item < ApplicationRecord
  validates :name,             presence: true
  validates :description,      presence: true
  validates :category_id,      numericality: { other_than: 1, message: "can't be blank" }
  validates :state_id,         numericality: { other_than: 1, message: "can't be blank" }
  validates :postage_id,       numericality: { other_than: 1, message: "can't be blank" }
  validates :region_id,        numericality: { other_than: 1, message: "can't be blank" }
  validates :shipping_date_id, numericality: { other_than: 1, message: "can't be blank" }

  with_options presence: true, format: { with: /\A[0-9]+\z/ } do
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      presence: { message: "can't be blank" }
  end

  belongs_to :user
  has_one_attached :image
  validates :image, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :postage
  belongs_to :region
  belongs_to :shipping_date
end
