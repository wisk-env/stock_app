class AddInvitedByFamilyIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :invited_by_family_id, :integer
  end
end
