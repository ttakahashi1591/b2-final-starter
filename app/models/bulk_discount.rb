class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchants
end
