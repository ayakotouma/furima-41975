# README

## テーブル設計

### usersテーブル
ユーザー情報を管理するテーブルです。

| カラム名           | 型         | オプション              | 説明            |
|-------------------|-----------|-----------------------|----------------|
| nickname           | string   | null: false               | ニックネーム             |
| email              | string   | null: false, unique: true | メールアドレス（重複不可） |
| encrypted_password | string   | null: false               | パスワード               |
| last_name          | string   | null: false               | 苗字(全角)               |
| first_name         | string   | null: false               | 名前(全角)               |
| last_name_kana     | string   | null: false               | 苗字カナ(全角)            |
| first_name_kana    | string   | null: false               | 名前カナ(全角)            |
| birthday           | date     | null: false               | 生年月日                 |

#### アソシエーション
- has_many :items
- has_many :purchase_records

### items テーブル
商品情報を管理するテーブルです。

| カラム名           | 型         | オプション              | 説明            |
|-------------------|-----------|-----------------------|----------------|
| name              | string      | null: false                    | 商品名                   |
| description       | text        | null: false                    | 商品の説明                |
| category_id       | integer     | null: false                    | カテゴリー                |
| condition_id      | integer     | null: false                    | 商品の状態                |
| shipping_fee_id   | integer     | null: false                    | 配送料の負担              |
| prefecture_id     | integer     | null: false                    | 発送元の地域              |
| shipping_day_id  | integer     | null: false                    | 発送までの日数             |
| price             | integer     | null: false                    | 販売価格                  |
| user              | references  | null: false, foreign_key: true | 出品者（ユーザーの外部キー） |

#### アソシエーション
- belongs_to :user
- has_one :purchase_record

### PurchaseRecords テーブル
購入記録を管理するテーブルです。

| カラム名     | 型       | オプション               | 説明                     |
|--------------|----------|--------------------------|--------------------------|
| item         | references  | null: false, foreign_key: true  | 購入品（商品の外部キー）      |
| user         | references  | null: false, foreign_key: true  | 購入者（ユーザーの外部キー）   |

#### アソシエーション
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

### ShippingAddresses テーブル
発送先情報を管理するテーブルです。

| カラム名     | 型       | オプション               | 説明                     |
|--------------|----------|--------------------------|--------------------------|
| postal_code      | string     | null: false                     | 郵便番号            |
| prefecture_id    | integer    | null: false                     | 都道府県            |
| city             | string     | null: false                     | 市区町村            |
| address          | string     | null: false                     | 番地               |
| building_name    | string     |                                 | 建物名              |
| phone_number     | string     | null: false                     | 電話番号            |
| purchase_record  | references | null: false, foreign_key: true  | （購入記録の外部キー） |

#### アソシエーション
- belongs_to :purchase_record
