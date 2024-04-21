class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, { only: [:show, :edit] }

  def index
    @user = User.find(current_user.id)
    @stocks = @user.stocks.order('id DESC')
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def create
    @stock = Stock.new(stock_params)
    @stock.user_id = current_user.id
    tag_list = params[:stock][:name].split(' ')
    if @stock.save
      @stock.save_tag(tag_list)
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

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    redirect_to :stocks
  end

  def ensure_correct_user
    @stock = Stock.find(params[:id])
    return unless @stock.user_id != current_user.id
    redirect_to :stocks
  end

  private

  def stock_params
    params.require(:stock).permit(:stock_name, :stock_qty, :category, :note, :stock_image, :user_id, :item_id)
  end
end
