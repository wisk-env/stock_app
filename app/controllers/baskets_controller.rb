class BasketsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @baskets = @user.baskets
  end

  def show
    @basket = Basket.find_by(id: params[:id])
    @purchase = Purchase.new
  end

  def create
    @basket = Basket.new(basket_params)
    if @basket.save
      redirect_to baskets_path
    else
      redirect_back fallback_location: stocks_path
    end
  end

  def edit
  end

  private

  def basket_params
    params.require(:basket).permit(:product_image, :product_name, :product_qty, :due_date, :stock_id, :user_id)
  end
end
