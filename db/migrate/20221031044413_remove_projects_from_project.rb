class RemoveProjectsFromProject < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :project_id, :integer
  end
end
