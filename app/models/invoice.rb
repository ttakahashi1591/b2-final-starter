class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def discounted_revenue
    InvoiceItem.select("invoice_items.id, ((invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * (MAX(bulk_discounts.percentage_discount)/100))) as discounted_revenue")
      .joins(item: {merchant: :bulk_discounts})
      .where('invoice_items.quantity >= bulk_discounts.quantity_threshold')
      .group('invoice_items.id')
      .sum(&:discounted_revenue)
  end
end
