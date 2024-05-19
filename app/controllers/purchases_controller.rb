class PurchasesController < ApplicationController
  def create
    @purchase = Purchase.new(purchase_params)

    if @purchase.save
      redirect_to baskets_path
    else
      redirect_back fallback_location: baskets_path
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:basket_id, :user_id)
  end
end
