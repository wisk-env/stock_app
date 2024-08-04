class StocksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, { only: [:show, :edit] }
  before_action :set_q, only: [:index, :search]

  def index
    @user = User.find(current_user.id)
    @stocks = @user.stocks.order('id DESC').page(params[:page]).per(5)
    if @user.families.first.nil?
      @stock_categories = @user.stocks.select(:category).distinct
      @tag_lists = @user.tags.distinct
    else
      @group_stocks_category = Stock.joins(user: :user_groups).select('stocks.category').merge(UserGroup.where(family_id: current_user.families.first.id)).distinct
      @group_tag_lists = Tag.joins(users: :user_groups).merge(UserGroup.where(family_id: current_user.families.first.id)).distinct
      @group_users = User.joins(:user_groups).includes(:user_groups).merge(UserGroup.where(family_id: current_user.families.first.id))
      @group_stocks = Stock.joins(user: :user_groups).select('stocks.*').where.not(user_id: current_user.id).merge(UserGroup.where(family_id: current_user.families.first.id)).includes(:tags).order('id DESC')
    end
  end

  def show
    @stock = Stock.find(params[:id])
    @basket = Basket.new
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
    @tag_list = @stock.tags.pluck(:name).join(' ')
  end

  def update
    @stock = Stock.find(params[:id])
    tag_list = params[:stock][:name].split(' ')
    if @stock.update(stock_params)
      @stock.save_tag(tag_list)
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

  def stock_calendar
    @user = User.find(current_user.id)
    @stocks = @user.stocks
  end

  def search
    @user = User.find(current_user.id)
    if @user.families.first.nil?
      @results = @q.result.distinct.page(params[:page]).per(6)
    else
      @user_id = User.joins(:user_groups).includes(:user_groups).merge(UserGroup.where(family_id: current_user.families.first.id))
      @results = @q.result.order(id: "DESC").distinct.where(user_id: [@user_id.ids]).page(params[:page]).per(6)
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:stock_name, :stock_qty, :category, :note, :stock_image, :user_id, :item_id, :start_time)
  end

  def set_q
    @user = User.find(current_user.id)
    if @user.families.first.nil?
      @q = @user.stocks.ransack(params[:q])
    else
      @q = Stock.ransack(params[:q])
    end
  end
end
