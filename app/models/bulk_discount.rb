class BulkDiscount < ApplicationRecord
  validates :percentage_discount, presence: true
  validates :quantity_threshold, presence: true
  
  belongs_to :merchant
  has_many :items, through: :merchant
end
