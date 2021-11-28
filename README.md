## usersテーブル
| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| nickname             | string     | null: false                    |
| email                | string     | null: false                    |
| encrypted_password   | string     | null: false                    |
| last_name            | string     | null: false                    |
| first_name           | string     | null: false                    |
| last_name_kana       | string     | null: false                    |
| first_name_kana      | string     | null: false                    |
| birthday             | date       | null: false                    |

### Association
- has_many :items
- has_many :orders

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

## ordersテーブル
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |

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

