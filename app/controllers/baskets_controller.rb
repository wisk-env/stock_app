class BasketsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_purchase, { only: [:show, :edit] }
  before_action :ensure_correct_user, { only: [:edit] }

  def index
    @user = User.find(current_user.id)
    @baskets = @user.baskets.order('id DESC')
    if @user.families.first.present?
      @group_baskets = Basket.joins(user: :user_groups).where.not(user_id: current_user.id).merge(UserGroup.where(family_id: current_user.families.first.id))
    end
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
    @basket = Basket.find(params[:id])
  end

  def update
    @basket = Basket.find(params[:id])
    if @basket.update(basket_params)
      redirect_to baskets_path
    else
      render "edit"
    end
  end

  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy
    redirect_to :baskets
  end

  def ensure_purchase
    @basket = Basket.find_by(id: params[:id])
    return unless @basket.purchase 
    redirect_to :baskets
  end

  def ensure_correct_user
    @basket = Basket.find(params[:id])
    return unless @basket.user_id != current_user.id
    redirect_to :baskets
  end

  def destroy_selected_products
    @baskets = Basket.all
    checked_data = params[:deletes]&.keys
    if checked_data.nil?
      redirect_back fallback_location: baskets_path
    elsif @baskets.destroy(checked_data)
      redirect_to :baskets
    end
  end

  private

  def basket_params
    params.require(:basket).permit(:product_image, :product_name, :product_qty, :due_date, :stock_id, :user_id, :deletes)
  end
end
