require "rails_helper"

RSpec.describe "merchant bulk disounts show page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")
    
    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 7, merchant_id: @merchant1.id)
  end

  describe "as a merchant" do
    describe "when I am taken to a bulk discount edit page" do
      it "I see that the discounts current attributes are pre-poluated in the form and when I change any/all of the information and click submit, then I am redirected to the bulk discount's show page where I see that the discount's attributes have been updated " do
        visit edit_merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id)
save_and_open_page
        expect(page).to have_field("Percentage discount", with: @bulk_discounts_1.percentage_discount)
        expect(page).to have_field("Quantity threshold", with: @bulk_discounts_1.quantity_threshold)

        fill_in "Percentage discount", with: "0.30"
        fill_in "Quantity threshold", with: "12"

        click_on "Submit"

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1.id, @bulk_discounts_1.id))
        expect(page).to have_content("30%")
        expect(page).to have_content("12")
      end
    end
  end
end