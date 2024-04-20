class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :stock_name, null: false
      t.integer :stock_qty, null: false
      t.string :category
      t.string :note
      t.string :stock_image
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
