








class SolverIdToNullableBugs < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bugs, :solver_id, true
  end
end
