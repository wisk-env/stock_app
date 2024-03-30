class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_name
      t.string :item_image
      t.string :item_genre
      t.string :item_url_pc
      t.string :item_url_mobile

      t.timestamps
    end
  end
end
