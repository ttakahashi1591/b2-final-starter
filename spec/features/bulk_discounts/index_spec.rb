require "rails_helper"

RSpec.describe "merchant bulk disounts" do
  before(:each).do
    @merchant1 = Merchant.create!(name: "Hair Care")

    visit merchant_bulk_discounts_index_path(@merchant1)
  end

  describe "As a merchant" do
    
  end
end