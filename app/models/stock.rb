class Stock < ApplicationRecord
  validates :stock_name, presence: true
  validates :stock_qty, presence: true, numericality: true

  belongs_to :user
  belongs_to :item

  has_many :stock_tags, dependent: :destroy
  has_many :tags, through: :stock_tags
end
