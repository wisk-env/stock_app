class FamiliesController < ApplicationController
  def index
    @families = current_user.families
  end

  def new
    @family = Family.new
  end

  def create
    @user = User.find_by(id: current_user.id)
    if @user.families.create(family_params)
      redirect_to families_path
    else
      render 'new'
    end
  end

  private

  def family_params
    params.require(:family).permit(:name, user_ids: current_user.id)
  end
end
