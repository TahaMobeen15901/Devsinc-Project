class RemoveProjectIdFromBugs < ActiveRecord::Migration[7.0]
  def change
    remove_column :bugs, :project_id, :integer
  end
end
