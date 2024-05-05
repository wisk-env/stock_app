class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.string :product_name, null: false
      t.integer :product_qty
      t.string :product_image
      t.date :due_date
      t.references :stock, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
