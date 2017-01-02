class AddDeadlineAtToTodos < ActiveRecord::Migration[5.0]
  def change
    add_column :todos, :deadline_at, :timestamp
  end
end
