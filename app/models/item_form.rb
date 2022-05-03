class ItemForm
  include ActiveModel::Model
  attr_accessor( 
    :name, :description, :category_id, :state_id, :postage_id, :region_id, :shipping_date_id, :price, :user_id, :images,
    :id, :created_at, :datetime, :updated_at, :datetime,
    :tag_name
  )

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
  validates :user_id, presence: true

  def save
    # item情報を保存し、変数itemに代入
    item = Item.create(name: name, description: description, category_id: category_id, state_id: state_id, 
                      postage_id: postage_id, region_id: region_id, shipping_date_id: shipping_date_id, price: price, user_id: user_id, images: images)
    # first_or_initializeメソッドを使い、入力されたtagがデータベースにあればそれを選択し、新規ならば新規保存をし、結果を変数tagに代入
    tag = Tag.where(tag_name: tag_name).first_or_initialize
    # tagを保存
    tag.save
    # 中間テーブルにitemとtagの紐付け情報を保存
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

  def update(params, item)
    #一度タグの紐付けを消すために中間テーブルの内容を削除
    item.item_tag_relations.destroy_all

    #paramsの中のタグの情報を削除。同時に、返り値として新たなタグの情報を変数に代入
    tag_name = params.delete(:tag_name)

    #もしタグの情報がすでに保存されていればインスタンスを取得、無ければインスタンスを新規作成
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?

    #タグを保存
    tag.save if tag_name.present?
    #商品を保存
    item.update(params)
    #中間テーブルに保存
    ItemTagRelation.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end
end