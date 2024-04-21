class StockTag < ApplicationRecord
  belongs_to :stock
  belongs_to :tag
  belongs_to :user
  validates :stock_id, presence: true
  validates :tag_id, presence: true
  validates :user_id, presence: true
end
