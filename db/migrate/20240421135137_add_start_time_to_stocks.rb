class AddStartTimeToStocks < ActiveRecord::Migration[5.2]
  def change
    add_column :stocks, :start_time, :datetime
  end
end
