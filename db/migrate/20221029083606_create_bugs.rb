class CreateBugs < ActiveRecord::Migration[7.0]
  def change
    create_table :bugs do |t|
      t.text :title
      t.date :deadline
      t.text :bug_type
      t.text :types_status
      t.belongs_to :user
      t.belongs_to :project
      t.timestamps
    end
  end
end
