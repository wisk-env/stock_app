class Stock < ApplicationRecord
  validates :stock_name, presence: true
  validates :stock_qty, presence: true, numericality: true
  
  belongs_to :user
  belongs_to :item
end
