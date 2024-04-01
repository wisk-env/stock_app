class StocksController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @stocks = @user.stocks.order('id DESC')
  end

  def show
  end

  def create
    @stock = Stock.new(stock_params)
    if @stock.save
      redirect_to stocks_path
    else
      redirect_back fallback_location: items_search_path
    end
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    if @stock.update(stock_params)
      redirect_to :stocks
    else
      redirect_back fallback_location: "edit"
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:stock_name, :stock_qty, :category, :note, :stock_image, :user_id, :item_id)
  end
end
