require "rails_helper"

RSpec.describe "merchant bulk disounts show page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Chair Fair")
    
    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 7, merchant_id: @merchant1.id)
    @bulk_discounts_2 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discounts_3 = BulkDiscount.create!(percentage_discount: 0.15, quantity_threshold: 8, merchant_id: @merchant2.id)
    @bulk_discounts_4 = BulkDiscount.create!(percentage_discount: 0.45, quantity_threshold: 9, merchant_id: @merchant2.id)
  end

  describe "as a merchant" do
    describe "when I visit my bulk discount show page" do
      it "then I see the bulk discount's quantity threshold and percentage discount" do
        visit merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id)

        within("#bulk_discount-show-#{@bulk_discounts_1.id}") do
          expect(page).to have_content("25%")
          expect(page).to have_content(@bulk_discounts_1.quantity_threshold)

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)
        end

        visit merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_2.id)

        within("#bulk_discount-show-#{@bulk_discounts_2.id}") do
          expect(page).to have_content("35%")
          expect(page).to have_content(@bulk_discounts_2.quantity_threshold)

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)
        end

        visit merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_3.id)

        within("#bulk_discount-show-#{@bulk_discounts_3.id}") do
          expect(page).to have_content("15%")
          expect(page).to have_content(@bulk_discounts_3.quantity_threshold)

          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)
        end

        visit merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_4.id)

        within("#bulk_discount-show-#{@bulk_discounts_4.id}") do
          expect(page).to have_content("45%")
          expect(page).to have_content(@bulk_discounts_4.quantity_threshold)

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
        end
      end

      it "then I see a link to edit the bulk discount and when I click this link I am then taken to a new page with a form to edit the discount" do
        visit merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id)

        within("#bulk_discount-show-#{@bulk_discounts_1.id}") do
          expect(page).to have_content("25%")
          expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_link("Edit This Bulk Discount")

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)

          click_link "Edit This Bulk Discount"

          expect(current_path).to eq(edit_merchant_bulk_discount_path(@bulk_discounts_1.id))
        end

        visit merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_2.id)

        within("#bulk_discount-show-#{@bulk_discounts_2.id}") do
          expect(page).to have_content("35%")
          expect(page).to have_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_link("Edit This Bulk Discount")

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)

          click_link "Edit This Bulk Discount"

          expect(current_path).to eq(edit_merchant_bulk_discount_path(@bulk_discounts_1.id))
        end

        visit merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_3.id)

        within("#bulk_discount-show-#{@bulk_discounts_3.id}") do
          expect(page).to have_content("15%")
          expect(page).to have_content(@bulk_discounts_3.quantity_threshold)
          expect(page).to have_link("Edit This Bulk Discount")

          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content("45%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_4.quantity_threshold)

          click_link "Edit This Bulk Discount"

          expect(current_path).to eq(edit_merchant_bulk_discount_path(@bulk_discounts_2.id))
        end

        visit merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_3.id)

        within("#bulk_discount-show-#{@bulk_discounts_4.id}") do
          expect(page).to have_content("45%")
          expect(page).to have_content(@bulk_discounts_4.quantity_threshold)
          expect(page).to have_link("Edit This Bulk Discount")

          expect(page).to have_no_content("15%")
          expect(page).to have_no_content("25%")
          expect(page).to have_no_content("35%")
          expect(page).to have_no_content(@bulk_discounts_1.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_2.quantity_threshold)
          expect(page).to have_no_content(@bulk_discounts_3.quantity_threshold)

          click_link "Edit This Bulk Discount"

          expect(current_path).to eq(edit_merchant_bulk_discount_path(@bulk_discounts_4.id))
        end
      end
    end
  end
end