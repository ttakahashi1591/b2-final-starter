require "rails_helper"

RSpec.describe "merchant bulk disounts new page" do
  before(:each) do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @bulk_discounts_1 = BulkDiscount.create!(percentage_discount: 0.25, quantity_threshold: 7, merchant_id: @merchant1.id)
    @bulk_discounts_2 = BulkDiscount.create!(percentage_discount: 0.35, quantity_threshold: 10, merchant_id: @merchant1.id)
    @bulk_discounts_3 = BulkDiscount.create!(percentage_discount: 0.55, quantity_threshold: 16, merchant_id: @merchant1.id)
  end

  describe "As a merchant" do
    describe "when I visit the bulk discounts new page" do
      it "then I see a form to add a new bulk discount where I do not fill in the form with valid data and then I am redirected back to the bulk discount new page where I see a flash alert" do
        visit new_merchant_bulk_discount_path(@merchant1.id)

        fill_in("Percentage discount", with: "")
        fill_in("Quantity threshold", with: "")

        click_button("Create Bulk Discount")
        
        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
        expect(page).to have_content("Please Fill Out The Entire Form!")
      end
      
      it "then I see a form to add a new bulk discount where I fill in the form with valid data and then I am redirected back to the bulk discount index page where I see my new bulk discount listed" do
        visit new_merchant_bulk_discount_path(@merchant1.id)

        fill_in("Percentage discount", with: "0.77")
        fill_in("Quantity threshold", with: "3")
save_and_open_page
        click_button("Create Bulk Discount")
        
        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1.id))
        expect(page).to have_content("Bulk Discount was successfully created!")
        expect(page).to have_content("77%")
        expect(page).to have_content("3")
      end
    end   
  end
end