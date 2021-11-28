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
| birth_date           | string     | null: false                    |

### Association
- has_many :items
- has_many :orders
- has_many :comments

## itemsテーブル

| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| name                 | text       | null: false                    |
| description          | text       | null: false                    |
| category             | string     | null: false                    |
| condition            | string     | null: false                    |
| which_bears_fee      | string     | null: false                    |
| sender_prefecture    | string     | null: false                    |
| shipping_days        | string     | null: false                    |
| price                | string     | null: false                    |
| user_id              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one    :order
- has_many   :comments

## ordersテーブル

| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| credit_card_number   | string     | null: false                    |
| expiration_date      | string     | null: false                    |
| security_number      | string     | null: false                    |
| postal_code          | string     | null: false                    |
| shipping_prefecture  | string     | null: false                    |
| shipping_municipality| string     | null: false                    |
| shipping_address     | string     | null: false                    |
| building_name        | string     |                                |
| phone_number         | string     | null: false                    |
| user_id              | references | null: false, foreign_key: true |
| item_id              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## commentsテーブル

| Column               | Type       | Options                        |
| ------               | ---------- | ------------------------------ |
| content              | text       | null: false                    |
| user_id              | references | null: false, foreign_key: true |
| item_id              | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

