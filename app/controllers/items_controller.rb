class ItemsController < ApplicationController
  def search
    if params[:keyword]
      items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
      @items_array = []
      items.each do |item|
        @items_array.push(item)
      end
      if @items_array.present?
        @items = Kaminari.paginate_array(@items_array).page(params[:page]).per(10)
      end
    end
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      redirect_back fallback_location: items_search_path
    end
  end

  def show
    @item = Item.find_by(id: params[:id])
    @stock = Stock.new
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_image, :item_genre, :item_url_pc, :item_url_mobile)
  end
end
