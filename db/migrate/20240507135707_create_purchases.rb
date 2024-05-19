class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :basket, null: false, index: { unique: true }, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
