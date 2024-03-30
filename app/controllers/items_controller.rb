class ItemsController < ApplicationController
  def search
    if params[:keyword]
      @items = RakutenWebService::Ichiba::Product.search(keyword: params[:keyword])
    end
  end
end
