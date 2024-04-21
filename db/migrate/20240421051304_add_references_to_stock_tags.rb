class AddReferencesToStockTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_tags, :user, foreign_key: true
  end
end
