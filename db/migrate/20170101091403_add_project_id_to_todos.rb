class AddProjectIdToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :project_id, :integer
    add_index :todos, :project_id
  end
end
