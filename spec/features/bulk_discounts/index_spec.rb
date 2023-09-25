require "rails_helper"

RSpec.describe "merchant bulk disounts index page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Chair Fair")

    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 7, merchant_id: @merchant1.id)
    @bulk_discounts_2 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discounts_3 = BulkDiscount.create!(percentage_discount: 0.55, quantity_threshold: 16, merchant_id: @merchant1.id)
    @bulk_discounts_4 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 8, merchant_id: @merchant2.id)
    @bulk_discounts_5 = BulkDiscount.create!(percentage_discount: 0.45, quantity_threshold: 9, merchant_id: @merchant2.id)
    @bulk_discounts_6 = BulkDiscount.create!(percentage_discount: 0.65, quantity_threshold: 12, merchant_id: @merchant2.id)
  end

  describe "As a merchant" do
    describe "when I visit my bulk discounts index page" do
      it "then I see all of my bulk discounts including their percentage discount and quantity thresholds as well as each bulk discount listed includes a link to its show page" do
        visit merchant_bulk_discounts_path(@merchant1.id)
        
        within("#bulk_discount-index-#{@merchant1.id}") do
          expect(page).to have_content("25%")
          expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_content("35%")
          expect(page).to have_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_content("55%")
          expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content("65%")
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_5.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_6.quantity_threshold)
        end

        visit merchant_bulk_discounts_path(@merchant2.id)

        within("#bulk_discount-index-#{@merchant2.id}") do
          expect(page).to have_content("15%")
          expect(page).to have_content(@bulk_discounts_4.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_content("45%")
          expect(page).to have_content(@bulk_discounts_5.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_content("65%")
          expect(page).to have_content(@bulk_discounts_6.quantity_threshold)
          expect(page).to have_link("Discount Details")

          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content("55%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
        end
      end

      it "then I see a link to create a new discount and when I click this link, then I am taken to a new page where I see a form to add a new bulk discount" do
        visit merchant_bulk_discounts_path(@merchant1.id)

        expect(page).to have_link("Create New Bulk Discount")

        click_link("Create New Bulk Discount")
          
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
      end
    end   
  end
end