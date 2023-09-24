require "rails_helper"

RSpec.describe "merchant bulk disounts" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Chair Fair")

    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 5, merchant_id: @merchant1.id)
    @bulk_discounts_2 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discounts_3 = BulkDiscount.create!(percentage_discount: 0.50, quantity_threshold: 15, merchant_id: @merchant1.id)
    @bulk_discounts_4 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 6, merchant_id: @merchant2.id)
    @bulk_discounts_5 = BulkDiscount.create!(percentage_discount: 0.45, quantity_threshold: 9, merchant_id: @merchant2.id)
    @bulk_discounts_6 = BulkDiscount.create!(percentage_discount: 0.60, quantity_threshold: 12, merchant_id: @merchant2.id)
  end

  describe "As a merchant" do
    it "then I am taken to my bulk discounts index page where I see all of my bulk discounts including their percentage discount and quantity thresholds as well as each bulk discount listed includes a link to its show page" do
      visit merchant_bulk_discounts_path(@merchant1.id)
      
      within("#bulk_discount-index-#{@merchant1.id}") do
        expect(page).to have_content(@bulk_discounts_1.percentage_discount)
        expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
        expect(page).to have_link("Discount Details")

        expect(page).to have_content(@bulk_discounts_2.percentage_discount)
        expect(page).to have_content(@bulk_discounts_2.quantity_threshold)
        expect(page).to have_link("Discount Details")

        expect(page).to have_content(@bulk_discounts_1.percentage_discount)
        expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
        expect(page).to have_link("Discount Details")
      end

      visit merchant_bulk_discounts_path(@merchant2.id)

      within("#bulk_discount-index-#{@merchant2.id}") do
        expect(page).to have_content(@bulk_discounts_4.percentage_discount)
        expect(page).to have_content(@bulk_discounts_4.quantity_threshold)
        expect(page).to have_link("Discount Details")

        expect(page).to have_content(@bulk_discounts_5.percentage_discount)
        expect(page).to have_content(@bulk_discounts_5.quantity_threshold)
        expect(page).to have_link("Discount Details")

        expect(page).to have_content(@bulk_discounts_6.percentage_discount)
        expect(page).to have_content(@bulk_discounts_6.quantity_threshold)
        expect(page).to have_link("Discount Details")
        save_and_open_page
      end
    end   
  end
end