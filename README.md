# テーブル設計

## usersテーブル

| Column             | Type   | Options     |
|--------------------|--------|-------------|
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| last_name_kana     | string | null: false |
| first_name_kana    | string | null: false |
| date_of_birthday   | date   | null: false |

### Association
- has_many :items
- has_many :purchase_records

## itemsテーブル

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| item_name         | string     | null: false                    |
| item_text         | string     | null: false                    |
| category          | string     | null: false                    |
| item_status       | string     | null: false                    |
| shipping_charges  | string     | null: false                    |
| shipping_location | string     | null: false                    |
| days_ required    | string     | null: false                    |
| price             | integer    | null: false                    |
| user_id           | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :purchase_record

## shipping_addressesテーブル

| Column              | Type       | Options                        |
|---------------------|------------|------------------------------- |
| postal_code         | string     | null: false                    |
| prefectures         | string     | null: false                    |
| municipalities      | string     | null: false                    |
| address             | string     | null: false                    |
| building_name       | string     |                                |
| tel_num             | string     | null: false                    |
| purchase_record_id  | references | null: false, foreign_key: true |

## purchase_recordsテーブル

| Column  | Type       | Options                        |
|---------|------------|--------------------------------|
| user_id | references | null: false, foreign_key: true |
| item_id | references | null: false, foreign_key: true |

### Association
- has_one :shipping_address