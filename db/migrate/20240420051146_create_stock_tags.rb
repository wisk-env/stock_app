class CreateStockTags < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_tags do |t|
      t.references :stock, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    add_index :stock_tags, [:stock_id, :tag_id], unique: true
  end
end
