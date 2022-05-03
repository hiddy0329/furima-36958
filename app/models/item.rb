class Item < ApplicationRecord
  has_one :order
  belongs_to :user
  has_many_attached :images
  has_many :comments
  has_many :item_tag_relations
  has_many :tags, through: :item_tag_relations

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :state
  belongs_to :postage
  belongs_to :region
  belongs_to :shipping_date
end
