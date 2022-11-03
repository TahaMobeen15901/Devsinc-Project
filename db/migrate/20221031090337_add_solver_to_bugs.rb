









class AddSolverToBugs < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :solver, null: false
    add_foreign_key :bugs, :users, column: :solver_id
  end
end
