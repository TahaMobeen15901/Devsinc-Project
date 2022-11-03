class RemoveBugIdFromProjects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :bug_id, :integer
  end
end
