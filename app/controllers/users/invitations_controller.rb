class Users::InvitationsController < Devise::InvitationsController
  def new
    super
  end

  def create
    super
  end

  def edit
    super
  end

  def update
    super
    @group = UserGroup.new
    @group.user_id = User.find_by(email: @user.email).id
    @group.family_id = User.find_by(email: @user.email).invited_by_family_id
    @group.save
  end

  def destroy
    super
  end
end
