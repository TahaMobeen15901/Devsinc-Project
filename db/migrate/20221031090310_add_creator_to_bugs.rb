









class AddCreatorToBugs < ActiveRecord::Migration[7.0]
  def change
    add_reference :bugs, :creator, null: false
    add_foreign_key :bugs, :users, column: :creator_id
  end
end
