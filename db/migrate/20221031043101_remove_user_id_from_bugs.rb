class RemoveUserIdFromBugs < ActiveRecord::Migration[7.0]
  def change
    remove_column :bugs, :user_id, :integer
  end
end
