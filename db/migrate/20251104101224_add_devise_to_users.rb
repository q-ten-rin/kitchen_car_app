class AddDeviseToUsers < ActiveRecord::Migration[7.2]
  def up
    # usersテーブルの構造を変更する
    change_table :users do |t|
      # --- 認証に必要なカラム ---
      # パスワードを暗号化して保存する
      t.string :encrypted_password, null: false, default: ""

      # --- パスワード再設定用 ---
      # リセット用のトークンと、その送信時間
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      # --- ログイン状態保持（remember me）用 ---
      t.datetime :remember_created_at
    end

    # トークンにユニーク制約を追加
    add_index :users, :reset_password_token, unique: true
  end

  def down
    # ロールバック時にDevise関連カラムを削除する
    change_table :users do |t|
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
    end
  end
end
