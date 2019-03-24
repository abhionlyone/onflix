class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.references :content, foreign_key: true
      t.references :variant
      t.datetime :expires_at

      t.timestamps
    end
  end
end
