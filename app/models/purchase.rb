class Purchase < ApplicationRecord
  belongs_to :basket
  belongs_to :user
end
