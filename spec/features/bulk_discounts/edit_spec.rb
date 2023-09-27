require "rails_helper"

RSpec.describe "merchant bulk disounts show page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Chair Fair")
    
    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 7, merchant_id: @merchant1.id)
    @bulk_discounts_2 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 10, merchant_id: @merchant2.id)
  end

  describe "as a merchant" do
    describe "when I am taken to a bulk discount edit page" do
      it "I see that the discounts current attributes are pre-poluated in the form and when I change any/all of the information and click submit, then I am redirected to the bulk discount's show page where I see that the discount's attributes have been updated " do
        visit new_merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id)

        within("#bulk_discount-new-#{@bulk_discounts_1.id}") do
          expect(find_field("Pecentage discount")).to eq("25%")
          expect(find_field("Quantity threshhold")).to eq(@bulk_discounts_1.quantity_threshold)

          fill_in "Percentage discount", with: "0.30"
          fill_in "Quantity threshold", with: "12"

          click_on "Submit"

          expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id))
          expect(page).to have_content("30%")
          expect(page).to have_content(@bulk_discounts_1.quantity_threshold)
        end

        visit merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_2.id)

        within("#bulk_discount-new-#{@bulk_discounts_2.id}") do
          expect(find_field("Pecentage discount")).to eq("35%")
          expect(find_field("Quantity threshhold")).to eq(@bulk_discounts_2.quantity_threshold)

          fill_in "Percentage discount", with: "0.40"
          fill_in "Quantity threshold", with: "14"

          click_on "Submit"

          expect(current_path).to eq(merchant_bulk_discount_path(@merchant2.id, @bulk_discounts_2.id))
          expect(page).to have_content("40%")
          expect(page).to have_content(@bulk_discounts_2.quantity_threshold)
        end
      end
    end
  end
end