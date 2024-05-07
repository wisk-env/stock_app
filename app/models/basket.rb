class Basket < ApplicationRecord
  validates :product_name, presence: true
  validates :product_qty, presence: true, numericality: true
  validates :due_date, presence: true

  belongs_to :stock
  belongs_to :user
end
