class Stock < ApplicationRecord
  validates :stock_name, presence: true
  validates :stock_qty, presence: true, numericality: true

  belongs_to :user
  belongs_to :item

  has_many :stock_tags, dependent: :destroy
  has_many :tags, through: :stock_tags

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(name: old_tag)
    end

    new_tags.each do |new_tag|
      new_stock_tag = Tag.find_or_create_by(name: new_tag)
      stock_tags.new(user_id: user_id, tag_id: new_stock_tag.id).save
    end
  end
end
