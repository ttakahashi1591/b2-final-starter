class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id]
    )
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)

    if @bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
      flash[:alert] = "Bulk Discount was successfully created!"   
    else
      flash[:alert] = "Please Fill Out The Entire Form!"
      render 'new'
    end
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity_threshold)
  end
end