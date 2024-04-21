class Tag < ApplicationRecord
  has_many :stock_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :stocks, through: :stock_tags
  has_many :users, through: :stock_tags

  validates :name, uniqueness: true, presence: true
end
