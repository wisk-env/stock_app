class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :family
  validates :user_id, presence: true
  validates :family_id, presence: true
end
