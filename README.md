## usersテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| nickname             | string     | null: false                    |
| email                | string     | null: false, unique: true      |
| encrypted_password   | string     | null: false                    |
| last_name            | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name_kana       | string     | null: false                    |
| first_name_kana      | string     | null: false                    |
| birthday             | date       | null: false                    |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## itemsテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| name                 | string     | null: false                    |
| description          | text       | null: false                    |
| category_id          | integer    | null: false                    |
| state_id             | integer    | null: false                    |
| postage_id           | integer    | null: false                    |
| region_id            | integer    | null: false                    |
| shipping_date_id     | integer    | null: false                    |
| price                | integer    | null: false                    |
| user                 | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one    :order
- has_many :comments
- has_many :item_tag_relations
- has_many :tags, through: :item_tag_relations

- extend ActiveHash::Associations::ActiveRecordExtensions
- belongs_to :category
- belongs_to :state
- belongs_to :postage
- belongs_to :region
- belongs_to :shipping_date

## ordersテーブル
| Column                  | Type       | Options                        |
| ------                  | ---------- | ------------------------------ |
| user                    | references | null: false, foreign_key: true |
| item                    | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one    :address

## addressesテーブル
| Column                  | Type       | Options                        |
| ------                  | ---------- | ------------------------------ |
| postal_code             | string     | null: false                    |
| shipping_prefecture_id  | integer    | null: false                    |
| shipping_municipality   | string     | null: false                    |
| shipping_address        | string     | null: false                    |
| building_name           | string     |                                |
| phone_number            | string     | null: false                    |
| order                   | references | null: false, foreign_key: true |

### Association
- belongs_to :order

## commentsテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| text                 | text       | null: false                    |
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## tagsテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| tag_name             | string     | null: false, uniqueness: true  |

### Association
- has_many :item_tag_relations
- has_many :items, through: :item_tag_relations

## item_tag_relationsテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| item                 | references | null: false, foreign_key: true |
| tag                  | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to :tag




